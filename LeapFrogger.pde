/*
Is there just one level, that is the same (aside from intro/ctrls)?

Maybe have a mini "hand" display on the side to show relative loc and stuff.
*/

import de.voidplus.leapmotion.*;

// Program variables
LeapMotion leap;
final int targetFrameRate = 0;

// Game variables
GameState gameState;
ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
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
//
//

// Done loading?
int load_finished = 0;

void setup() {
  size(700, 600);
  leap = new LeapMotion(this);
  
  gameState = GameState.Load;
  
  Thread imageLoader = new Thread() {
    @Override
    public void run() {
      screen_background = loadImage("sheet.png").get(1, 1, 255, 221);
      screen_background.resize(500, 500);
      // other image loads
      load_finished++;
    }
  };
  
  imageLoader.start();
  
  frog = new PlayerCharacter();
  
  background(0);
  stroke(255);
  
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
  image(screen_background, 0, 0, width, height);
  frog.display();
  // draw all objects based on their current positions. Don't do any variable updating (update all frames?, to continue animating things?)
  for (int i = 0; i < obstacles.size(); i++) {
    obstacles.get(i).display();
  }
  fill(0);
  text("game", 200, 200);
}

void updateGameFrame() {
  // change variables (move logs by speed, move frog by speed
  fill(0);
  text("updated game", 200, 250);
}

float getScreenPosX(float tilePosX) { // if the board is a 16x16 square, with a border of 12px, return tilePosX*((width-12*$2.0)/16)
  return 0;
}

float getScreenPosY(float tilePosY) { // if the board is a 16x16 square, with a border of 12px, return tilePosY*((height-12*$2.0)/16)
  return 0;
}
