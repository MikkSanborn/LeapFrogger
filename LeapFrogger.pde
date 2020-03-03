/*
CarObstacle(Texture t, float x, float y, float xs, float ys, float x_bound, float w, float h)
 LogObstacle(Texture t, float x, float y, float w, float h)
 
 */

// Required libraries
import de.voidplus.leapmotion.*;

// Program variables
LeapMotion leap; // A LeapMotion controller
final int targetFrameRate = 20; // The framerate that should be expected of the game.
GameState gameState;
final float controlThreshold = 12;
int controlDelay = 500;

// Game variables

//   ///////////////////////////////////////////////////////////////////////////////////////////
//   ||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||
//   \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
// ALL OBSTACLE VARS
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();

// 5 lanes, LOOK AT "THINGIES" TAB FOR INFO
CarObstacle car_1_0 = null; // slow
CarObstacle car_1_1 = null; // slow
CarObstacle car_1_2 = null; // slow

CarObstacle car_2_0 = null; // slowest
CarObstacle car_2_1 = null; // slowest
CarObstacle car_2_2 = null; // slowest
CarObstacle car_2_3 = null; // slowest

CarObstacle car_3_0 = null; // slow
CarObstacle car_3_1 = null; // slow
CarObstacle car_3_2 = null; // slow

CarObstacle car_4_0 = null; // fastest
CarObstacle car_4_1 = null; // fastest

CarObstacle car_5_0 = null; // bus (long slow boi)
CarObstacle car_5_1 = null; // bus (long slow boi)

// Water
// Logs
TurtleObstacle turtle_7_0 = null; // 4 wide
TurtleObstacle turtle_7_1 = null; // 4 wide
TurtleObstacle turtle_7_2 = null; // 4 wide
// LogObstacle turtle_7_3 = null; // 4 wide

LogObstacle log_8_0 = null; // 2 med sm, 2 med lg (smaller)
LogObstacle log_8_1 = null; // 2 med sm, 2 med lg (larger)
LogObstacle log_8_2 = null; // 2 med sm, 2 med lg (smaller)
// LogObstacle log_8_3 = null; // 2 med sm, 2 med lg (croco/larger)

TurtleObstacle turtle_9_0 = null; // 3 two wide, 1 four wide (2 wide)
TurtleObstacle turtle_9_1 = null; // 3 two wide, 1 four wide (2 wide)
TurtleObstacle turtle_9_2 = null; // 3 two wide, 1 four wide (2 wide)
// TurtleObstacle turtle_9_3 = null; // 3 two wide, 1 four wide (4 wide)

LogObstacle log_10_0 = null; // 2 longest, 2 shortest (shortest)
LogObstacle log_10_1 = null; // 2 longest, 2 shortest (longest)
LogObstacle log_10_2 = null; // 2 longest, 2 shortest (shortest)
LogObstacle log_10_cheat = null; // 2 longest, 2 shortest (longest)

final short maxLives = 3;
PImage screen_background;
Texture water_background;

// Player related variables
PlayerCharacter frog;
short lives = maxLives;

// Score tracking variables
int session_highscore = 0;
int score = 0;

// Scoring variables/values
int how_far_you_have_gone_so_far_in_y_direction = 0; // so you can't jump forwards and backwards for free points (you sneeky cheater)
final int pointsForJump = 10; // jumping forwards

// Done loading?
int load_finished = 0;

void setup() {
  size(700, 500);

  leap = new LeapMotion(this);

  initStuff();

  println(load_finished);
}

void draw() {
  showGame();

  if (keyPressed && key == 'm') {
    frog.moveTo((mouseX-30)/40.0, 10);
    println((mouseX-30)/40.0);
  }
}
