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
LogObstacle turle_7_0 = null;
LogObstacle log_8_0 = null;
LogObstacle turtle_9_0 = null;
LogObstacle log_10_0 = null;

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
      log_8_0 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 38, 144, 15)}), getScreenPosX(0), getScreenPosY(2), 300, 30, false);
      log_8_0 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 58, 72, 15)}), getScreenPosX(0), getScreenPosY(2), 300, 30, false);
      log_8_0 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 78, 56, 15)}), getScreenPosX(0), getScreenPosY(2), 300, 30, false);
      log_8_0 = new LogObstacle(new Texture(new PImage[] {sheet.get(262, 98, 32, 15)}), getScreenPosX(0), getScreenPosY(2), 300, 30, false);
      
      
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
  for (int i = 0; i < obstacles.size(); i++) {
    obstacles.get(i).display();
  }
  fill(0);
  text("game", 600, 50);
  text("score", 600, 150);
}

void updateGameFrame() {
  // change variables (move logs by speed, move frog by speed
  if (frameCount%5 == 0) {
    water_background.nextFrame(); // all frame increments to be done here.
  }
  for (Obstacle o : obstacles) {
    if (o instanceof MoveableObstacle) {
      ((MoveableObstacle) o).move(); 
    }
  }
  fill(0);
  text("updated game", 200, 250);
}

float getScreenPosX(float tilePosX) { // if the board is a 16x16 square, with a border of 12px, return tilePosX*((width-12*$2.0)/16)
  return ;
}

float getScreenPosY(float tilePosY) { // if the board is a 16x16 square, with a border of 12px, return tilePosY*((height-12*$2.0)/16)
  return height-30*tilePosY;
}
