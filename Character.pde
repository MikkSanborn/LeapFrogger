abstract class Character {
  float x; // float for when on moving objects
  float y; // floar for jumoing forwards/back
  
  
}

class NonPlayerCharacter extends Character {
  
}

class PlayerCharacter extends Character {
  public final static float w = 1;
  public final static float h = 1;
  
  float xs, ys;
  char[] controlKeys = new char[4]; // UP, LEFT, DOWN, RIGHT (wasd config)
  boolean isAlive;
  
  boolean isColliding(Obstacle o) {
    return (x >= o.x && y >= o.y && x+w <= o.x+o.w && y+h <= o.y+o.h);
  }
}
