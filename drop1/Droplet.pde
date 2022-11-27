/*********
 Flood of tears
 Danielle Honigstein
 Free for personal and commercial use with attribution and link to
 this site.
 
 Class representing a droplet that splashes when drop hits the flood.
 **********/
class Droplet {
  PVector pos; //position of droplet
  PVector vel;//velocity of droplet
  PVector gravity = new PVector(0, 10);//gravity
  color c;//color of droplet

  //create droplet with random velocity
  Droplet(PVector pos, color c) {
    this.pos = pos;
    this.c = c;
    vel = new PVector(random(-20, 20), random(-30, -70));
  }

  //using given color to draw the droplet and update position and velocity.
  void draw() {
    fill(c);
    noStroke();
    circle(pos.x, pos.y, 10);
    vel.add(gravity);
    pos.add(vel);
  }
}
