/*
Is there just one level, that is the same (aside from intro/ctrls)
*/

import de.voidplus.leapmotion.*;

LeapMotion leap;
int screen = -1;
/*
-3 = set ctrls?
-2 = look at ctrls
-1 = main
0 = game
*/

void setup() {
  size(800, 600);
  leap = new LeapMotion(this);

  background(0);
  stroke(255);
}

void draw() {
  displayScreen(screen);
}

float getScreenPosX(float tilePosX) { // if the board is a 16x16 square, with a border of 12px, return tilePosX*((width-12*$2.0)/16)
  return 0;
}

float getScreenPosY(float tilePosY) { // if the board is a 16x16 square, with a border of 12px, return tilePosY*((height-12*$2.0)/16)
  return 0;
}
