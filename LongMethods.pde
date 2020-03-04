// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void initStuff() {
  gameState = GameState.Load;

  Thread imageLoader = new Thread() {
    @Override
      public void run() {
      PImage sheet = loadImage("sheet.png");
      screen_background = sheet.get(1, 1, 255, 221);
      screen_background.resize(500, 500);
      water_background = new Texture(new PImage[] {sheet.get(1, 228, 256, 80), sheet.get(1, 228+85, 256, 80), sheet.get(1, 228+85*2, 256, 80), sheet.get(1, 228+85*3, 256, 80), sheet.get(1, 228+85*4, 256, 80), sheet.get(1, 228+85*5, 256, 80), sheet.get(1, 228+85*6, 256, 80), sheet.get(1, 228+85*7, 256, 80)}); // 8 total, 5px down from the prev
      // other image loads
      frogComplete = new Texture(new PImage[] {sheet.get(262, 18, 16, 16), sheet.get(283, 18, 16, 16), sheet.get(304, 18, 16, 16), sheet.get(324, 18, 16, 16)});

      car_1_0 = new CarObstacle(new Texture(new PImage[] {sheet.get(357, 196, 23, 15)}), getScreenPosX(0), getScreenPosY(1)-12.5, 40, 25, -1.2, 40); // slow l
      car_1_1 = new CarObstacle(new Texture(new PImage[] {sheet.get(357, 196, 23, 15)}), getScreenPosX(4), getScreenPosY(1)-12.5, 40, 25, -1.2, 40); // slowest, slow
      car_1_2 = new CarObstacle(new Texture(new PImage[] {sheet.get(357, 196, 23, 15)}), getScreenPosX(8), getScreenPosY(1)-12.5, 40, 25, -1.2, 40); // slowest, slow

      car_2_0 = new CarObstacle(new Texture(new PImage[] {sheet.get(328, 196, 24, 15)}), getScreenPosX(0), getScreenPosY(2)-12.5, 50, 25, 0.8, 50); // fast, slowest r
      car_2_1 = new CarObstacle(new Texture(new PImage[] {sheet.get(328, 196, 24, 15)}), getScreenPosX(4), getScreenPosY(2)-12.5, 50, 25, 0.8, 50); // fast, slowest
      car_2_2 = new CarObstacle(new Texture(new PImage[] {sheet.get(328, 196, 24, 15)}), getScreenPosX(6), getScreenPosY(2)-12.5, 50, 25, 0.8, 50); // fast, slowest
      car_2_3 = new CarObstacle(new Texture(new PImage[] {sheet.get(328, 196, 24, 15)}), getScreenPosX(10), getScreenPosY(2)-12.5, 50, 25, 0.8, 50); // fast, slowest

      car_3_0 = new CarObstacle(new Texture(new PImage[] {sheet.get(384, 196, 25, 15)}), getScreenPosX(1), getScreenPosY(3)-12.5, 50, 25, -1.2, 50); // middle, slow l
      car_3_1 = new CarObstacle(new Texture(new PImage[] {sheet.get(384, 196, 25, 15)}), getScreenPosX(5), getScreenPosY(3)-12.5, 50, 25, -1.2, 50); // middle, slow
      car_3_2 = new CarObstacle(new Texture(new PImage[] {sheet.get(384, 196, 25, 15)}), getScreenPosX(9), getScreenPosY(3)-12.5, 50, 25, -1.2, 50); // middle, slow

      car_4_0 = new CarObstacle(new Texture(new PImage[] {sheet.get(299, 196, 25, 15)}), getScreenPosX(0), getScreenPosY(4)-12.5, 50, 25, 3, 50); // fastest, SPEED r
      car_4_1 = new CarObstacle(new Texture(new PImage[] {sheet.get(299, 196, 25, 15)}), getScreenPosX(6), getScreenPosY(4)-12.5, 50, 25, 3, 50); // fastest, SPEED

      car_5_0 = new CarObstacle(new Texture(new PImage[] {sheet.get(414, 195, 39, 16)}), getScreenPosX(0), getScreenPosY(5)-17.5, 80, 35, -1, 80); // bus (long slow boi), slowest l
      car_5_1 = new CarObstacle(new Texture(new PImage[] {sheet.get(262, 196, 32, 15)}), getScreenPosX(7), getScreenPosY(5)-17.5, 80, 35, -1, 80); // bus (long slow boi), slowest

      /*      
       7 = water 1 (turtle) fastest spd L
       8 = water 2 (log) slow (/middle after, but missing a lane) spd R
       9 = water 3 (turle) slow+ spd L
       10 = water 4 (log) middle spd R
       */

      turtle_7_0 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(7)-15, 128, 30, -2.5, 144, true);
      turtle_7_1 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(5), getScreenPosY(7)-15, 128, 30, -2.5, 144, true);
      turtle_7_2 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(10), getScreenPosY(7)-15, 128, 30, -2.5, 144, true);
      // turtle_7_3 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(0), 111, 111, 0.6, true);

      log_8_0 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 78, 56, 15)}), getScreenPosX(-1), getScreenPosY(8)-15, 112, 30, 1, 144);
      log_8_1 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 58, 72, 15)}), getScreenPosX(4), getScreenPosY(8)-15, 144, 30, 1, 144);
      log_8_2 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 58, 72, 15)}), getScreenPosX(10), getScreenPosY(8)-15, 144, 30, 1, 144);

      turtle_9_0 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 157, 32, 15), sheet.get(299, 157, 32, 15), sheet.get(336, 157, 32, 15), sheet.get(373, 157, 32, 15), sheet.get(262, 176, 32, 15), sheet.get(299, 176, 32, 15), sheet.get(336, 176, 32, 15), sheet.get(373, 176, 32, 15)}), getScreenPosX(0), getScreenPosY(9)-15, 64, 30, -1.2, 128, true);
      turtle_9_1 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 157, 32, 15), sheet.get(299, 157, 32, 15), sheet.get(336, 157, 32, 15), sheet.get(373, 157, 32, 15), sheet.get(262, 176, 32, 15), sheet.get(299, 176, 32, 15), sheet.get(336, 176, 32, 15), sheet.get(373, 176, 32, 15)}), getScreenPosX(4), getScreenPosY(9)-15, 64, 30, -1.2, 128, true);
      turtle_9_2 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(8), getScreenPosY(9)-15, 128, 30, -1.2, 128, true);

      log_10_0 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 98, 32, 15)}), getScreenPosX(0), getScreenPosY(10)-15, 64, 30, 2.2, 288);
      log_10_1 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 98, 32, 15)}), getScreenPosX(5), getScreenPosY(10)-15, 64, 30, 2.2, 288);
      log_10_2 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 38, 144, 15)}), getScreenPosX(10), getScreenPosY(10)-15, 288, 30, 2.2, 288);

      // log_10_cheat = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 38, 144, 15)}), 0, getScreenPosY(10)-15, 500, 30, 0, 0);

      // log_10_3 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 38, 144, 15)}), getScreenPosX(12), getScreenPosY(10)-15, 288, 30, -1.2, 288);

      // Add references to each obstacle
      obstacles.add(car_1_0);
      obstacles.add(car_1_1);
      obstacles.add(car_1_2);

      obstacles.add(car_2_0);
      obstacles.add(car_2_1);
      obstacles.add(car_2_2);
      obstacles.add(car_2_3);

      obstacles.add(car_3_0);
      obstacles.add(car_3_1);
      obstacles.add(car_3_2);

      obstacles.add(car_4_0);
      obstacles.add(car_4_1);

      obstacles.add(car_5_0);
      obstacles.add(car_5_1);

      // blank area

      obstacles.add(turtle_7_0);
      obstacles.add(turtle_7_1);
      obstacles.add(turtle_7_2);

      obstacles.add(log_8_0);
      obstacles.add(log_8_1);
      obstacles.add(log_8_2);
      // obstacles.add(log_8_3);

      obstacles.add(turtle_9_0);
      obstacles.add(turtle_9_1);
      obstacles.add(turtle_9_2);
      // obstacles.add(turtle_9_3);

      obstacles.add(log_10_0);
      obstacles.add(log_10_1);
      obstacles.add(log_10_2);

      // obstacles.add(log_10_cheat);

      for (int i = 0; i < water_background.frames.length; i++) {
        water_background.frames[i].resize(500, 180);
      }
      load_finished++;
    }
  };

  imageLoader.start();

  // frog = new PlayerCharacter(null, 400, 400);

  background(0);
  stroke(255);

  frameRate(targetFrameRate);

  load_finished++;
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void showGame() {
  background(0);

  switch (gameState) {
  case Play:
    frog.currentLog = null;
    drawGame(); // draw game
    if (frog.hasScored == 0) {
      frog.control(); // update frog pos
    }    
    updateGameFrame(); // update all other screen elements' pos', and check for collision or frog in water

    fill(255);
    rect(500, 0, 200, height);


    if (frog.hasScored != 0) {
      frog.hasScored++;
      fill(255);
      textSize(72);
      text("You Scored!", 50, 260);
      textSize(12);
      if (frog.hasScored == 50) {
        frog.hasScored = 0;
        frog.scoringMaxP = 0;
        frog.moveTo(5, 0);
      }
    }

    showScoreStuff();

    break;

  case Pause:
    drawGame();
    // pause overlay
    break;

  case Load:
    background(255);
    fill(0);
    text("Loading...", 200, 200);
    // text: loading assets...
    // maybe when almost done use some frame count variable to make the textures come on
    if (load_finished >= 2) {
      gameState = GameState.Main;
    }
    break;

  case Main:
    drawGame();
    updateGameFrame(); // pretty background (just has moving thingies)
    gameState = GameState.Play;
    break;

  case Dead:
    drawGame();
    updateGameFrame();

    fill(255, 255, 255);
    textSize(72);
    text("You died!", 143, 260);

    textSize(12);
    fill(255);
    rect(500, 0, 200, height);

    showScoreStuff();
    // respawn / respawn timer
    break;

  default:
    gameState = GameState.Load;
    break;
  }
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void drawGame() {
  background(255);

  fill(0, 0, 255);
  for (int i = 0; i < 5; i++) {
    if (frameCount % 10 == 0) {
      frogComplete.nextFrame();
    }
    if (posScored[i]) {
      rect(100*i, 0, 100, 100);
      // draw frog
      // .425, 2.75, 5.125, 7.525, 9.9
      PImage frogImg = frogComplete.currentFrame();
      float w = PlayerCharacter.w;
      float h = PlayerCharacter.h;
      switch (i) {
      case 0:
        image(frogImg, getScreenPosX(.425), getScreenPosY(11)-h/2, w, h);
        break;
      case 1:
        image(frogImg, getScreenPosX(2.75), getScreenPosY(11)-h/2, w, h);
        break;
      case 2:
        image(frogImg, getScreenPosX(5.125), getScreenPosY(11)-h/2, w, h);
        break;
      case 3:
        image(frogImg, getScreenPosX(7.525), getScreenPosY(11)-h/2, w, h);
        break;
      case 4:
        image(frogImg, getScreenPosX(9.9), getScreenPosY(11)-h/2, w, h);
        break;
      }
    }
  }
  // draw the background image here
  // image(screen_background, 0, 0, screen_background.width*2, screen_background.height*2);
  image(screen_background, 0, 0);
  image(water_background.thisFrame(), 0, 53);
  frog.display();

  // draw all objects based on their current positions. Don't do any variable updating (update all frames?, to continue animating things?)
  for (Obstacle o : obstacles) {
    try {
      o.display();
    } 
    catch (NullPointerException npe) {
      // object not instantiated, but we will assume that this is ok.
    }
  }
  frog.display();

  //// move later
  //fill(0);
  //text("Death time:", 520, 400);
  //text(frog.deathTimer, 520, 425);
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void updateGameFrame() {
  frog.isOnGround = false;
  // change variables (move logs by speed, move frog by speed
  if (frameCount%5 == 0) {
    water_background.nextFrame(); // all frame increments to be done here.
  }

  // UPDATE ALL OBSTACLES
  for (Obstacle o : obstacles) {
    if (o instanceof MoveableObstacle)
      ((MoveableObstacle) o).move(); // move it
    frog.collideWith(o); // test if colliding with froggo
  }

  // check if alive
  frog.checkAlive();

  frog.moveOnLog();
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void showScoreStuff() {

  textSize(12);
  fill(0);
  text("Lives remaining:", 520, 200);
  text(lives, 520, 220);
  text("Score:", 520, 250);
  text(score, 520, 270);

  if (score > highscore) {
    highscore = score;
  }
  text("Highscore:", 520, 300);
  text(highscore, 520, 320);

  if (lives == -1) {
    score = 0;
    lives = maxLives;
    posScored = new boolean[] {false, false, false, false, false};
  }
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
float getScreenPosX(float tilePosX) { // EXPECT 0-10
  // if the board is a 16x16 square, with a border of 12px, return tilePosX*((width-12*$2.0)/16)
  // ref the img. img original size: (256x222), output size = (500x500)
  return 30 + 40*tilePosX; // estimate : gives 30 px padding with 40 px width spaces
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
float getScreenPosY(int tilePosY) { // EXPECT 0-11 (11 is a "special case")
  // if the board is a 16x16 square, with a border of 12px, return tilePosY*((height-12*$2.0)/16)

  switch (tilePosY) {
  case 0:
    return 470;
  case 1:
    return 437.5;
  case 2:
    return 405;
  case 3:
    return 367.5;
  case 4:
    return 332;
  case 5:
    return 290;
  case 6:
    return 247.5;
  case 7:
    return 207.5;
  case 8:
    return 162.5;
  case 9:
    return 117.5;
  case 10:
    return 72.5;
  case 11:
    return 32.5;
  default:
    if (tilePosY < 0) {
      return -100;
    } else if (tilePosY > 11) {
      return width+100;
    } else {
      println("something weird with getTilePosY(" + tilePosY + ")");
    }
  }

  return height-30-40*tilePosY; // estimate : gives some padding
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
void resetGame() {
  frog.moveTo(5, 0);

  score = 0;

  // timer = 0

  gameState = GameState.Play;

  lives = maxLives;
}
