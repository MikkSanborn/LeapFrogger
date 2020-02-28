class Movement {
float yaw, pitch, roll, y, p, r;
float posX, posY, PX, PY;
float carXS, carYS, carYD, carXD;
int[] horizontal = new int[11];
int[] vertical = new int[11];
int loopH, loopV;
int trackH, trackV;
int countH1, countV1, countH2, countV2, num1, num2;
boolean t;
int timing = 500;
long timeLastInput = 0;

void setup() {

  t = true;

  size(700, 600);//(really 500 by 500)
  noStroke();                      //turns off the outline when drawing a shape
  background(255);

  posX = 400;
  posY = 300;

  for (int i = 0; i<11; i++) {
    horizontal[i] = loopH;
    vertical[i] = loopV;
    loopH +=45.5;
    loopV+=45.5;
  }
}

void draw() {

  // background(0);
  background(255);

  long timeNow = millis();
  if (timeNow-timeLastInput > timing) {


    for (Hand hand : leap.getHands()) {
      y = hand.getYaw();
      p = hand.getPitch();
      r = hand.getRoll();
      yaw = map(y, -180, 180, -90, 90);
      pitch = map(p, -180, 180, -90, 90);
      roll = map(r, -180, 180, -90, 90);

      PX = roll;
      PY = pitch;

        if (PX>10) {
        timeLastInput = timeNow;
        trackH ++;
      } else if (PX <= -10) {
        timeLastInput = timeNow;
        trackH--;
      } else if (PY > 10) {
        timeLastInput = timeNow;
        trackV++;
      } else if (PY <= -10) {
        trackV--;
        timeLastInput = timeNow;
      }

      if (trackV > 9) {
        trackV = 9;
      } else if (trackV <0) {
        trackV = 0;
      }
      if (trackH >9) {
        trackH = 9;
      } else if (trackH <0) {
        trackH = 0;
      }

      //
      //delay(20);
    }
  }

  //draw stuff
  fill(0);
  ellipse(horizontal[trackH], vertical[trackV], 50, 50);


  //debug
  fill(0);
  rect(0, 0, 300, 180);    
  fill(255);
  textSize(20);
  text("Yaw: " + yaw, 0, 30);
  text("Pitch: " + pitch, 0, 60);
  text("Roll: " + roll, 0, 90);
  text("X: " + PX, 0, 120);
  text("Y: " + PY, 0, 150);
}
}
