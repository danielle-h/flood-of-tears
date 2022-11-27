/*********
Flood of tears
Danielle Honigstein
Free for personal and commercial use with attribution and link to 
this site.

main code
Starts with one tear that becomes a flood and fills the screen.
Drops splash using droplets when they hit the ground.
**********/


//arrays of drops and droplets
ArrayList<Drop> drops = new ArrayList<Drop>();
ArrayList<Droplet> droplets = new ArrayList<Droplet>();

//when to create a new drop
long prevTime = 0;
long currTime = 0;
int interval = 3000;//ms

//flood height and growth rate
int flood;
boolean added = false;



void setup() {
  size(800, 500);
  background(0);

  drops.add(new Drop(width/2, 75));//one drop in the center
  flood = height;//no flood yet
}

void draw() {
  background(0);

  currTime = millis();

  if (currTime-prevTime > interval) {//if time to create a new drop create it
    added = false;
    drops.add(new Drop(random(30, width-30), -10));
    prevTime = currTime;
    if (interval>20) {//minimum interval is 20 ms
      //shorten interval
      interval  = int(0.8*interval );
    }
  }
  //draw, add droplets and remove drops as necessary
  int n = drops.size()-1;
  for (int i = n; i>=0; i--) {
    Drop tmp = drops.get(i);
    tmp.draw();
    if (tmp.y >=flood) {//below flood level, remove and add droplets instead
      int numParts = int(random(1, 5));
      for (int j = 0; j<numParts; j++) {
        droplets.add(new Droplet(new PVector(tmp.x, tmp.y), color(0, tmp.green, tmp.blue)));
      }
      drops.remove(i);
      if (flood > 0) {//update flood with new drop
        if (!added) {
          added = true;
          flood -=10;
        }
      }
      if (flood ==0) {//pause at the end
        noLoop();
      }
    }
  }
  //draw and remove droplets as necessary
  for (int i = 0; i< droplets.size(); i++) {
    droplets.get(i).draw();
    if (droplets.get(i).pos.y >flood) {
      droplets.remove(i);
    }
  }
  //draw flood
  fill(0, 85, 255);
  rect(0, flood, width, height - flood);
}
