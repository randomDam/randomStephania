void effect0(PGraphics pg) {
  pg.image(canvasInput, 0, 0, pg.width, pg.height);

  for (int i=0; i<pg.width; i+=20) {
    for (int j=0; j<pg.height; j+=20) {
      pg.stroke(0);
      pg.strokeWeight(4);
      pg.line(i, j, i+5, j+5);
    }
  }
}




void effect1(PGraphics pg) {
  //pg.image(inputVideo, 0, 0, pg.width, pg.height);
  pg.noStroke();

  for (int i=0; i<pg.width; i+=50) {
    for (int j=0; j<pg.height; j+=50) {
      /*pg.copy(
       inputVideo,i,j,50,50,
       i,j,100,100
       );*/

      float de = random(10);

      int dec=50;
      int decA=50;
      if (de<1) {
        pg.beginShape();
        pg.texture(canvasInput);

        pg.vertex(i, j, i, j);
        pg.vertex(i+dec, j, i+decA, j);
        pg.vertex(i+dec, j+dec, i+decA, j+decA);
        pg.vertex(i, j+dec, i, j+decA);
        pg.endShape(CLOSE);
      }
    }
  }
}




void effect2(PGraphics pg) {
  //pg.image(inputVideo, 0, 0, pg.width, pg.height);
  pg.noStroke();

  for (int i=0; i<pg.width; i+=50) {
    for (int j=0; j<pg.height; j+=50) {
      /*pg.copy(
       inputVideo,i,j,50,50,
       i,j,100,100
       );*/

      float de = random(10);

      int dec=10;
      int decA=50;
      if (de<1) {
        pg.beginShape();
        pg.texture(canvasInput);

        pg.vertex(i, j, i, j);
        pg.vertex(i+dec, j, i+decA, j);
        pg.vertex(i+dec, j+dec, i+decA, j+decA);
        pg.vertex(i, j+dec, i, j+decA);
        pg.endShape(CLOSE);
      } else if (de<0.1) {
        decA=10;

        pg.beginShape();
        pg.texture(canvasInput);

        pg.vertex(i, j, i, j);
        pg.vertex(i+dec, j, i+decA, j);
        pg.vertex(i+dec, j+dec, i+decA, j+decA);
        pg.vertex(i, j+dec, i, j+decA);
        pg.endShape(CLOSE);
      }
    }
  }
}


void effect3(PGraphics pg) {
  //pg.image(inputVideo, 0, 0, pg.width, pg.height);
  pg.noStroke();
  //pg.loadPixels();
  //inputVideo.updatePixels();
  int x=0;
  int y=0;
  int pres=20;

  for (int i=0; i<canvasInput.pixels.length; i+=pres) {
    if (brightness(canvasInput.pixels[i])>100) {
      /*
      for (int k=0; k<pres; k++) {
        pg.set(x, y, color(inputVideo.pixels[i]));
        pg.set(x+k, y, color(inputVideo.pixels[i]));
        pg.set(x, y+k, color(inputVideo.pixels[i]));
        pg.set(x+k, y+k, color(inputVideo.pixels[i]));
      }*/
      pg.fill(canvasInput.pixels[i]);
      pg.rect(x, y, random(pres),pres);
      
    }
    x+=pres;
    if (x>=canvasInput.width) {
      x=0;
      y++;
    }
  }

  //pg.updatePixels();
}
