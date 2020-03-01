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
  int timing = 800;
  long timeLastInput = 0;

  // float xs, ys;
  boolean isAlive;
  boolean isOnGround = false;
  int deathTimer = 0; // counts how long to keep the frog dead, and also for invincibilty frames at the start.

  public PlayerCharacter(Texture t, float x, float y) {
    super(t, x, y, PlayerCharacter.w, PlayerCharacter.h);

    trackH = 5;
    trackV = 0;

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
    return (x+h >= o.x && y+h >= o.y && x <= o.x+o.w && y <= o.y+o.h);
  }

  void collideWith(Obstacle o) {
    if (!isColliding(o)) return; // if this isn't colliding

    o.displayDebug();

    if (gameState == GameState.Play && deathTimer == 0) { // check if deathTimer == 0, so it isn't dead, and so it isn't "invincible"
      if (o instanceof CarObstacle) {
        this.kill();
        return;
      } else if (o instanceof LogObstacle) {
        if (o instanceof TurtleObstacle) {
          Texture turtle_t = ((TurtleObstacle) o).t;
          if (turtle_t.currentFrameNum() == turtle_t.numFrames()-1) {
            return; // don't make it "on ground"
            // this.kill();
          }
        }

        isOnGround = true; // if it is interacting with the log, it is on it, so the frog is not on the ground.
      }
    }

    // isOnGround = true if not on water, and true if on log over water
  }

  void display() {
    super.display();

    ////debug
    //fill(255);
    //textSize(20);
    //// text("Yaw: " + yaw, 0, 30);
    //text("Pitch: " + pitch, 0, 60);
    //text("Roll: " + roll, 0, 90);
    //text("X: " + PX, 0, 120);
    //text("Y: " + PY, 0, 150);
  }

  void move() { // primarily to check state-based effects, i.e. if it has fallen in the water.
    if (trackV <= 6 || trackV >= 11) isOnGround = true;

    // Check for some cases
    if (gameState == GameState.Play) { // If you're playing...
      if (super.x > 500 || super.x < 0) { // ...and the frog is off the screen,
        this.kill(); // something is weird, kill it,
        return; // and then we'll be done here.
      }
      if (deathTimer < 0) {
        deathTimer++;
      }
    } else if (gameState == GameState.Dead) {
      deathTimer--;
      if (deathTimer <= 0) {
        this.respawn();
        deathTimer = -10; // short period of invincibility because debugging.
      }
    }
  }

  void kill() {
    if (isAlive) {
      gameState = GameState.Dead;
      deathTimer = 50; // set the time until respawn for 50 frames
      // moveTo start, but do that on the "respawn button", if that's a thing?
      lives--;
      if (lives <= 0) {
        // ur dead!
        // basically reset the score
      }
      isAlive = false;
    }
  }

  void respawn() {
    if (!isAlive) {
      // moveTo(initpos);
      moveTo(5, 0);
      gameState = GameState.Play;
      deathTimer = 0;
      isAlive = true;
    }
  }

  void control() {
    // background(0);
    // background(255);

    long timeNow = millis();
    if (timeNow-timeLastInput > timing) { // don't accept inputs too quickly

      if (keyPressed) {
        if (keyCode == UP) {
          trackV++;
          timeLastInput = timeNow;
        } else if (keyCode == DOWN) {
          trackV--;
          timeLastInput = timeNow;
        } else if (keyCode == LEFT) {
          trackH--;
          timeLastInput = timeNow;
        } else if (keyCode == RIGHT) {
          trackH++;
          timeLastInput = timeNow;
        }
      }

      for (Hand hand : leap.getHands()) { // for each hand??? maybe only do one...
        // y = hand.getYaw();
        p = hand.getPitch();
        r = hand.getRoll();
        //  yaw = map(y, -180, 180, -90, 90);
        pitch = map(p, -180, 180, -90, 90);
        roll = map(r, -180, 180, -90, 90);

        PX = roll;
        PY = pitch;


        if (PY > controlThreshold) {
          timeLastInput = timeNow;
          trackV--;
        } else if (PY <= -controlThreshold) {
          trackV++;
          timeLastInput = timeNow;
        } else if (PX > controlThreshold) { // perhaps we should split them? probably not, but as a precaution or something like that
          timeLastInput = timeNow;
          trackH++;
        } else if (PX <= -controlThreshold) {
          timeLastInput = timeNow;
          trackH--;
        }
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

      x = getScreenPosX(trackH);
      y = getScreenPosY(trackV)-h/2;
    }
  }

  void moveTo(int x, int y) {
    trackH = x;
    trackV = y;
  }
}
