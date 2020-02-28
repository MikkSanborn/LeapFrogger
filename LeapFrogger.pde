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

  initStuff();

  println(load_finished);
}

void draw() {
  background(0);
  // println(gameState);

  showGame();
}

float getScreenPosX(float tilePosX) { // if the board is a 16x16 square, with a border of 12px, return tilePosX*((width-12*$2.0)/16)
  return 30 + 40*tilePosX; // gives 30 px padding with 40 px width spaces
}

float getScreenPosY(float tilePosY) { // if the board is a 16x16 square, with a border of 12px, return tilePosY*((height-12*$2.0)/16)
  return height-30-40*tilePosY;
}
