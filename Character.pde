class PlayerCharacter extends Obstacle {
  public final static float w = 30;
  public final static float h = 30;

  int jumpFrame = 0; // If jumping, count up frames until it gets there, and base the pos and frame off of this (i.e. framenum: jumpFrame/20)

  float pitch, roll, p, r;
  boolean hasScored = false; // represents if the frog has scored points in this life at row 11
  float endPointLeniency = 0.5;
  float PX, PY;
  // float carXS, carYS, carYD, carXD;
  // int loopH, loopV;
  float trackH, prevTrackH;
  int trackV, prevTrackV;
  // int countH1, countV1, countH2, countV2, num1, num2;
  long timeLastInput = 0;

  // float xs, ys;
  boolean isAlive;
  boolean isOnGround = false;
  int deathTimer = 0; // counts how long to keep the frog dead, and also for invincibilty frames at the start.
  int scoringMaxP = 0;
  // int score = 0;
  boolean forward = true;
  long maxTime = 150;

  LogObstacle currentLog; // represents the log that you're on right now

  public PlayerCharacter(Texture t, float x, float y) {
    super(t, x, y, PlayerCharacter.w, PlayerCharacter.h);

    currentLog = null;

    trackH = 5;
    trackV = 0;
    prevTrackV = -1;

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

    // o.displayDebug();

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
        currentLog =(LogObstacle) o;

        isOnGround = true; // if it is interacting with the log, it is on it, so the frog is not on the ground.
      }
    }

    // isOnGround = true if not on water, and true if on log over water
  }

  void moveOnLog() {
    if (currentLog == null) return;

    // super.x+=currentLog.xs;
    trackH+=currentLog.xs/40.0;
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

  void checkAlive() { // primarily to check state-based effects, i.e. if it has fallen in the water.
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
    // moveTo(initpos);
    trackH = 5;
    prevTrackH = 5;
    trackV = 0;
    prevTrackV = 0;
    gameState = GameState.Play;
    deathTimer = 0;
    isAlive = true;
    scoringMaxP = 0;
  }

  void control() {
    // background(0);
    // background(255);

    long timeNow = millis();
    if (timeNow-timeLastInput > controlDelay) { // don't accept inputs too quickly

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
      } // end each hand

      //if (currentLog.x == PX) {
      //  PX+=currentLog.xs;
      //}

      if (PY > controlThreshold) {
        timeLastInput = timeNow;
        // scoringMaxP = trackV;
        trackV--;
        // forward = false;
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
    } // end time elsapsed statement

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

    if (trackH != prevTrackH && trackV != 11) {
      // check that it hasn't been shifted away, and if it has, slide the trackH by the deltaX
      if (x - getScreenPosX(trackH) != getScreenPosX(prevTrackH)-getScreenPosX(trackH)) {
        float diff = x - getScreenPosX(trackH);
        trackH += (int) (diff/40.0);
      }
      if (trackV < 7) { // allow 11
        trackH = (int) (trackH + 0.5);
      }

      x = getScreenPosX(trackH);
    }
    if (trackV != prevTrackV) {
      if (trackV == 11 && prevTrackV == 10) {
        if (trackH > .425-endPointLeniency && trackH < .425+endPointLeniency) {
          trackH = .425;
          x = getScreenPosX(trackH);
        } else if (trackH > 2.75-endPointLeniency && trackH < 2.75+endPointLeniency) {
          trackH = 2.75;
          x = getScreenPosX(trackH);
        } else if (trackH > 5.125-endPointLeniency && trackH < 5.125+endPointLeniency) {
          trackH = 5.125;
          x = getScreenPosX(trackH);
        } else if (trackH > 7.525-endPointLeniency && trackH < 7.525+endPointLeniency) {
          trackH = 7.525;
          x = getScreenPosX(trackH);
        } else if (trackH > 9.9-endPointLeniency && trackH < 9.9+endPointLeniency) {
          trackH = 9.9;
          x = getScreenPosX(trackH);
        } else {
          this.kill();
        }
        // .425, 2.75, 5.125, 7.525, 8.85
      }
      y = getScreenPosY(trackV)-h/2;
    }

    if (trackV == 11 && !hasScored) {
      score+=50;
      hasScored = true;
      // score+=(maxTime-timeNow)/2; // do this, but differently
    }

    if (scoringMaxP < trackV) {
      score+=10;
      scoringMaxP = trackV;
    }

    prevTrackV = trackV;
    prevTrackH = trackH;
  }


  void moveTo(float x, int y) {
    trackH = x;
    trackV = y;
  }
}
