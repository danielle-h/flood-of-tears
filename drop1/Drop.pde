/*********
 Flood of tears
 Danielle Honigstein
 Free for personal and commercial use with attribution and link to
 this site.
 
 Class representing a drop. It is drop shaped using a custom PShape,
 and falls down the screen, changing alpha slightly on the way.
 
 **********/
class Drop {
  //position, could use PVector instead
  float x;
  float y;
  //color and alpha
  float alpha;
  float blue;
  float green;
  //drop shape
  PShape drop;
  //falling speed
  float speed;

  //when to update the position
  long currTime = 0;
  long prevTime = 0;
  int interval = 50;//ms

  //create new drop
  Drop(float x, float y) {
    //update position
    this.x = x;
    this.y = y;

    //starting alpha
    alpha  = 200;

    //using constant speed as this is meant to imitate tears.
    //if imitating rain, use random speeds
    //speed = random(3, 8);
    speed = 5;

    //starting color
    blue = random(280, 255);
    green = random(100, 200);

    //drop PShape
    drop = createShape();
    drop.beginShape(); // start to draw a shape
    drop.vertex(0, -50); // begin at this point x, y
    //top left of drop, curving in then out
    drop.bezierVertex(0, -50, 8, -25, 10, -20);
    drop.bezierVertex(10, -20, 17, -10, 20, 0.3);
    //bottom arc of drop
    for (float a = 0; a < PI; a += 0.1) {
      float r = 20;
      drop.vertex(r*cos(a), r*sin(a));
    }
    //top right of drop, curving in then out
    drop.bezierVertex(-20, 0.3, -17, -10, -10, -20);
    drop.bezierVertex(-10, -20, -8, -25, 0, -50);
    drop.endShape(CLOSE);
  }

  void draw() {//draw and update

    //we want to draw all the time, and update if interval passed
    currTime = millis();
    //draw
    drop.setFill(color(0, green, blue, alpha));
    drop.setStroke(color(0, green, blue, alpha));
    pushMatrix();
    translate(x, y);
    scale(0.5);
    shape(drop);
    popMatrix();
    //update if interval passed
    if (currTime-prevTime > interval) {
      prevTime = currTime;
      y = y+speed;
      alpha = alpha + random(-10, +10);
      alpha = constrain(alpha, 150, 255);
    }
  }
}
