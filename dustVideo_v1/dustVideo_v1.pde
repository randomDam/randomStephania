import processing.video.*;
import com.hamoid.*;

//input/output video flux
Movie inputVideo;
VideoExport outputVideo;

int fHD_width=1920;
int fHD_height=1080;
PGraphics canvas;

//----------------------------------------------------
// SETUP
//----------------------------------------------------
void setup() {
  size(1400, 606, P3D);
  background(0);
<<<<<<< HEAD
  frameRate(30);
=======
  frameRate(60);
>>>>>>> e80a46b8e6a6127897287ae6451a2f0aa3e58167

  inputVideo = new Movie(this, "gost.mp4");
  inputVideo.play();

  canvas = createGraphics(fHD_width, fHD_height, P3D);

  outputVideo = new VideoExport(this, "export.mp4", canvas);
<<<<<<< HEAD
  //outputVideo.setQuality(50,44000);
=======
  outputVideo.setQuality(50,44000);
>>>>>>> e80a46b8e6a6127897287ae6451a2f0aa3e58167
  
  outputVideo.startMovie();
}


//----------------------------------------------------
// DRAW
//----------------------------------------------------
void draw() {
  background(0);

  //GO to -EFFECT 
  canvas.beginDraw();//debut effect
  effects(canvas);
  canvas.endDraw();//fin effect

  //--------------------------------------------------------------------
  //preview de l'input
  int div=3;
  fill(255);
  image(inputVideo, 0, 100, fHD_width/div, fHD_height/div);
  text("input video", 0, 100-5);
  
  //preview de l'output
  image(canvas, fHD_width/div+50, 100, fHD_width/div, fHD_height/div);
  text("output video", fHD_width/div+50, 100-5);

  text("effect : "+de, fHD_width/div+50, 100-25);
  
  fill(255,255,0);
  text("fr : "+frameRate, 10, 100-25);

  outputVideo.saveFrame();
}


//----------------------------------------------------
// Movie event
//----------------------------------------------------
void movieEvent(Movie m) {
  m.read();
}
