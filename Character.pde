class PlayerCharacter extends Obstacle {
  public final static float w = 30;
  public final static float h = 30;

  int jumpFrame = 0; // If jumping, count up frames until it gets there, and base the pos and frame off of this (i.e. framenum: jumpFrame/20)

  float pitch, roll, p, r;
  float PX, PY;
  // float carXS, carYS, carYD, carXD;
  // int loopH, loopV;
  int trackH, trackV;
  // int countH1, countV1, countH2, countV2, num1, num2;
  int timing = 500;
  long timeLastInput = 0;

  // float xs, ys;
  boolean isAlive;

  public PlayerCharacter(Texture t, float x, float y) {
    super(t, x, y, PlayerCharacter.w, PlayerCharacter.h);
    
    // 
    isAlive = true;
    
    //for (int i = 0; i<11; i++) {
    //  horizontal[i] = loopH;
    //  vertical[i] = loopV;
    //  loopH +=45.5;
    //  loopV+=45.5;
    //}
  }

  boolean isColliding(Obstacle o) {
    return (x >= o.x && y >= o.y && x+w <= o.x+o.w && y+h <= o.y+o.h);
  }

  void display() {
    super.display();
    //noStroke();
    //image(t.currentFrame(), x, y, w, h);



    //draw stuff
    fill(0);
    //ellipse(getScreenPosX(trackH+1), getScreenPosY(trackV), 50, 50);

    //debug
    fill(0);
    // rect(0, 0, 300, 180);    
    fill(255);
    textSize(20);
    // text("Yaw: " + yaw, 0, 30);
    text("Pitch: " + pitch, 0, 60);
    text("Roll: " + roll, 0, 90);
    text("X: " + PX, 0, 120);
    text("Y: " + PY, 0, 150);
  }
  
  void move() {
    // if on log & stuff
  }

  void control() {
    // background(0);
    // background(255);

    long timeNow = millis();
    if (timeNow-timeLastInput > timing) {


      for (Hand hand : leap.getHands()) {
        // y = hand.getYaw();
        p = hand.getPitch();
        r = hand.getRoll();
        //  yaw = map(y, -180, 180, -90, 90);
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

        if (trackV > 11) {
          trackV = 11;
        } else if (trackV <0) {
          trackV = 0;
        }
        if (trackH >11) {
          trackH = 11;
        } else if (trackH <0) {
          trackH = 0;
        }

        //
        //delay(20);

        x = getScreenPosX(trackH);
        println(trackV + "   " + y);
        y = getScreenPosY(trackV);
      }
    }
  }
  
  void moveTo(float x, float y) {
    super.x = x;
    super.y = y;
  }
}
