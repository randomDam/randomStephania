import processing.video.*;
import com.hamoid.*;

//input/output video flux
Movie inputVideo;
VideoExport outputVideo;

int fHD_width=1920;
int fHD_height=1080;
PGraphics canvas, canvasInput;

PFont font;

//----------------------------------------------------
// SETUP
//----------------------------------------------------
void setup() {
  size(1400, 606, P3D);
  background(0);
  frameRate(25);

  font = loadFont("LucidaSans-12.vlw");
  textFont(font);

  inputVideo = new Movie(this, "launch2.mp4");
  inputVideo.play();

  canvasInput = createGraphics(fHD_width, fHD_height, P2D);
  canvasInput.beginDraw();
  canvasInput.background(255, 255, 0);
  canvasInput.endDraw();
  
  canvasInput.loadPixels();
  canvasInput.updatePixels();

  canvas = createGraphics(fHD_width, fHD_height, P3D);

  outputVideo = new VideoExport(this, "export.mp4", canvas);
  outputVideo.setQuality(50, 44000);

  outputVideo.startMovie();
}


//----------------------------------------------------
// DRAW
//----------------------------------------------------
void draw() {
  background(0);
  textFont(font);

  canvasInput.beginDraw();
  canvasInput.image(inputVideo, 0, 0, canvas.width, canvas.height);
  canvasInput.endDraw();
  canvasInput.loadPixels();

  //GO to -EFFECT 
  canvas.beginDraw();//debut effect
  effects(canvas);
  canvas.endDraw();//fin effect

  //--------------------------------------------------------------------
  //preview de l'input
  int div=3;
  fill(255);
  image(canvasInput, 0, 100, fHD_width/div, fHD_height/div);
  text("input video", 0, 100-5);

  //preview de l'output
  image(canvas, fHD_width/div+50, 100, fHD_width/div, fHD_height/div);
  text("output video", fHD_width/div+50, 100-5);

  text("effect : "+de, fHD_width/div+50, 100-25);

  fill(255, 255, 0);
  text("fr : "+frameRate, 10, 100-25);

  calcTime(690, 30);

  outputVideo.saveFrame();

  endMovie();
}


//----------------------------------------------------
// Movie event
//----------------------------------------------------
void movieEvent(Movie m) {
  m.read();
}


void calcTime(int x, int y) {
  stroke(255);
  fill(0);
  rect(x, y, 300, 14);

  fill(255);
  noStroke();
  rect(x, y, map(inputVideo.time(), 0, inputVideo.duration(), 0, 300), 14);

  text(int(inputVideo.time())+" / "+int(inputVideo.duration()), x+310, y+12);
}


void endMovie() {
  if (int(inputVideo.time()) == int(inputVideo.duration()) ) {
    outputVideo.endMovie();
    exit();
  }
}
