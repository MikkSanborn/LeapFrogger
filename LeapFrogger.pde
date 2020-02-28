/*
CarObstacle(Texture t, float x, float y, float xs, float ys, float x_bound, float w, float h)
 LogObstacle(Texture t, float x, float y, float w, float h)
 
 */

import de.voidplus.leapmotion.*;

// Program variables
LeapMotion leap;

final int targetFrameRate = 20;

// Game variables
GameState gameState;

/////////////////////////////////////////////////////////////////////////////////////////////
//||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// ALL OBSTACLE VARS
// 5 lanes, LOOK AT "THINGIES" TAB FOR INFO
CarObstacle car_1_0 = null;

// Water
// Logs
LogObstacle turtle_7_0 = null; // 4 wide
LogObstacle turtle_7_1 = null; // 4 wide
LogObstacle turtle_7_2 = null; // 4 wide
// LogObstacle turtle_7_3 = null; // 4 wide
LogObstacle log_8_0 = null; // 2 med sm, 2 med lg (smaller)
LogObstacle log_8_1 = null; // 2 med sm, 2 med lg (larger)
LogObstacle log_8_2 = null; // 2 med sm, 2 med lg (smaller)
LogObstacle log_8_3 = null; // 2 med sm, 2 med lg (croco)
LogObstacle turtle_9_0 = null; // 3 two wide, 1 four wide (2 wide)
LogObstacle turtle_9_1 = null; // 3 two wide, 1 four wide (2 wide)
LogObstacle turtle_9_2 = null; // 3 two wide, 1 four wide (2 wide)
LogObstacle turtle_9_3 = null; // 3 two wide, 1 four wide (4 wide)
LogObstacle log_10_0 = null; // 2 longest, 2 shortest (shortest)
LogObstacle log_10_1 = null; // 2 longest, 2 shortest (longest)
LogObstacle log_10_2 = null; // 2 longest, 2 shortest (shortest)
LogObstacle log_10_3 = null; // 2 longest, 2 shortest (longest)

final short maxLives = 3;
PImage screen_background;
Texture water_background;

// Player related variables
PlayerCharacter frog;
short lives = maxLives;
int jumpFrame = 0; // If jumping, count up frames until it gets there, and base the pos and frame off of this (i.e. framenum: jumpFrame/20)

// Score tracking variables
// int global_highscore = 0; // set from a text file, that is held from a globally viewable location, i.e. on GitHub (use curl?)
int local_highscore = 0; // set from a text file, that is held "locally", or on this computer (in ./data/) : // TO BE IMPLEMENTED //
int session_highscore = 0;
int score = 0;

// Scoring variables/values
final int pointsForJump = 10; // jumping forwars
// other points, check with Kaia
// getting the fly (100)
// pink frog (on log, 50)
// 

// Done loading?
int load_finished = 0;

void setup() {
  size(800, 600);
  leap = new LeapMotion(this);

  gameState = GameState.Load;

  Thread imageLoader = new Thread() {
    @Override
      public void run() {
      PImage sheet = loadImage("sheet.png");
      screen_background = sheet.get(1, 1, 255, 221);
      screen_background.resize(500, 500);
      water_background = new Texture(new PImage[] {sheet.get(1, 228, 256, 80), sheet.get(1, 228+85, 256, 80), sheet.get(1, 228+85*2, 256, 80), sheet.get(1, 228+85*3, 256, 80), sheet.get(1, 228+85*4, 256, 80), sheet.get(1, 228+85*5, 256, 80), sheet.get(1, 228+85*6, 256, 80), sheet.get(1, 228+85*7, 256, 80)}); // 8 total, 5px down from the prev
      // other image loads

      // ADD ALL OBSTACLES

      // ADD ALL IMAGES FOR EACH OBJECT
      // logs (all of them)
      // longest new LogObstacle(new Texture(new PImage[] {sheet.get(262, 38, 144, 15)}), getScreenPosX(0), getScreenPosY(2), 300, 30, false);
      // longer new LogObstacle(new Texture(new PImage[] {sheet.get(262, 58, 72, 15)}), getScreenPosX(0), getScreenPosY(2), 300, 30, false);
      // shorter new LogObstacle(new Texture(new PImage[] {sheet.get(262, 78, 56, 15)}), getScreenPosX(0), getScreenPosY(2), 300, 30, false);
      // shortest new LogObstacle(new Texture(new PImage[] {sheet.get(262, 98, 32, 15)}), getScreenPosX(0), getScreenPosY(2), 300, 30, false);

      turtle_7_0 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(7), 111, 111, 0.6, 600, false);
      turtle_7_1 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(7), 111, 111, 0.6, 600, false);
      turtle_7_2 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(7), 111, 111, 0.6, 600, false);
      // turtle_7_3 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(0), 111, 111, 0.6, false);

      log_8_0 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 78, 56, 15)}), getScreenPosX(0), getScreenPosY(2), 112, 30, 1, 600, false);
      log_8_1 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 58, 72, 15)}), getScreenPosX(0), getScreenPosY(2), 144, 30, 1, 600, false);
      log_8_2 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 78, 56, 15)}), getScreenPosX(0), getScreenPosY(2), 112, 30, 1, 600, false);
      log_8_3 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 58, 72, 15)}), getScreenPosX(0), getScreenPosY(2), 144, 30, 1, 600, false);

      turtle_9_0 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(9), 111, 111, 0.6, 600, false);
      turtle_9_1 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(9), 111, 111, 0.6, 600, false);
      turtle_9_2 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(9), 111, 111, 0.6, 600, false);
      turtle_9_3 = new TurtleObstacle(new Texture(new PImage[] {sheet.get(262, 117, 64, 15), sheet.get(331, 117, 64, 15), sheet.get(400, 117, 64, 15), sheet.get(469, 117, 64, 15), sheet.get(262, 137, 64, 15), sheet.get(331, 137, 64, 15), sheet.get(400, 137, 64, 15), sheet.get(469, 137, 64, 15)}), getScreenPosX(0), getScreenPosY(9), 111, 111, 0.6, 600, false);

      log_10_0 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 98, 32, 15)}), getScreenPosX(0), getScreenPosY(2), 64, 30, -1.2, 600, false);
      log_10_1 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 38, 144, 15)}), getScreenPosX(0), getScreenPosY(2), 288, 30, -1.2, 600, false);
      log_10_2 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 98, 32, 15)}), getScreenPosX(0), getScreenPosY(2), 64, 30, -1.2, 600, false);
      log_10_3 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 38, 144, 15)}), getScreenPosX(0), getScreenPosY(2), 288, 30, -1.2, 600, false);


      for (int i = 0; i < water_background.frames.length; i++) {
        water_background.frames[i].resize(500, 180);
      }
      load_finished++;
    }
  };

  imageLoader.start();

  frog = new PlayerCharacter(null, 400, 400);

  background(0);
  stroke(255);

  frameRate(targetFrameRate);

  load_finished++;

  println(load_finished);
}

void draw() {
  background(0);

  switch (gameState) {
  case Play:
    drawGame();
    updateGameFrame();
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
    break;

  case Dead:
    drawGame();
    updateGameFrame();
    // respawn / respawn timer
    break;

  default:
    gameState = GameState.Load;
    break;
  }
}

void drawGame() {
  background(255);
  // draw the background image here
  // image(screen_background, 0, 0, screen_background.width*2, screen_background.height*2);
  image(screen_background, 0, 0);
  image(water_background.thisFrame(), 0, 53);
  frog.display();

  // draw all objects based on their current positions. Don't do any variable updating (update all frames?, to continue animating things?)
  turtle_7_0.display();
  turtle_7_1.display();
  turtle_7_2.display();
  // turtle_7_3.display();
  log_8_0.display();
  log_8_1.display();
  log_8_2.display();
  log_8_3.display();
  turtle_9_0.display();
  turtle_9_1.display();
  turtle_9_2.display();
  turtle_9_3.display();
  log_10_0.display();
  log_10_1.display();
  log_10_2.display();
  log_10_3.display();
  
  frog.display();

  fill(0);
  text("game", 600, 50);
  text("score", 600, 150);
}

void updateGameFrame() {
  // change variables (move logs by speed, move frog by speed
  if (frameCount%5 == 0) {
    water_background.nextFrame(); // all frame increments to be done here.
  }

  // UPDATE ALL OBSTACLES
  turtle_7_0.move();
  turtle_7_1.move();
  turtle_7_2.move();
  // turtle_7_3.move();
  log_8_0.move();
  log_8_1.move();
  log_8_2.move();
  log_8_3.move();
  turtle_9_0.move();
  turtle_9_1.move();
  turtle_9_2.move();
  turtle_9_3.move();
  log_10_0.move();
  log_10_1.move();
  log_10_2.move();
  log_10_3.move();

  frog.move();

  fill(0);
  text("updated game", 200, 250);
}

float getScreenPosX(float tilePosX) { // if the board is a 16x16 square, with a border of 12px, return tilePosX*((width-12*$2.0)/16)
  return 30 + 40*tilePosX; // gives 30 px padding with 40 px width spaces
}

float getScreenPosY(float tilePosY) { // if the board is a 16x16 square, with a border of 12px, return tilePosY*((height-12*$2.0)/16)
  return height-30*tilePosY;
}
