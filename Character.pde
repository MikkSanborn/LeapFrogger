abstract class Character extends Obstacle {

  public Character(Texture t, float x, float y, float w, float h) {
    super(t, x, y, w, h);
  }

  abstract void display();
}

// maybe kill this???
class NonPlayerCharacter extends Character { // what are npc's?

  public NonPlayerCharacter(Texture t, float x, float y, float w, float h) {
    super(t, x, y, w, h);
  }

  void display() {
  }
}

class PlayerCharacter extends Character {
  public final static float w = 1;
  public final static float h = 1;

  float xs, ys;
  char[] controlKeys = new char[4]; // UP, LEFT, DOWN, RIGHT (wasd config)
  boolean isAlive;

  public PlayerCharacter(Texture t, float x, float y) {
    super(t, x, y, PlayerCharacter.w, PlayerCharacter.h);
  }

  boolean isColliding(Obstacle o) {
    return (x >= o.x && y >= o.y && x+w <= o.x+o.w && y+h <= o.y+o.h);
  }

  void display() {
  }
}
