// super type for all obstacles seen
abstract class Obstacle {
  float x, y; // tile occuped, top left
  float w, h; // usually 1x1

  Texture t;

  public Obstacle(Texture t, float x, float y, float w, float h) {
    this.t = t;
    this.x = x;
    this.y = y;
    this.w = w;
    this.h = h;
  }

  public Obstacle(Texture t, float w, float h) {
    this.t = t;
    this.x = 0;
    this.y = 0;
    this.w = w;
    this.h = h;
  }

  void display() {
    noStroke();
    image(t.currentFrame(), x, y, w, h);
  }
}

class MoveableObstacle extends Obstacle {

  public MoveableObstacle(Texture t, float x, float y, float w, float h) {
    super(t, x, y, w, h);
  }
  
  public void move() {
    super.x+=xs;
  }

  float xs;
  // no ys, at least not yet
}

// car
class CarObstacle extends MoveableObstacle {
  float xs, ys;
  float x_bound; // the boundary of the x where the car should "teleport" back to the other side.
  
  public CarObstacle(Texture t, float x, float y, float xs, float ys, float x_bound, float w, float h) {
    super(t, x, y, w, h);
    this.xs = xs;
    this.ys = ys;
    this.x_bound = x_bound;
  }
  
  public void move() {
    x += xs;
    
    if (x > x_bound) {
      x = -x_bound-w;
    }
  }
  // the cars
}

// a moving log, can be a croco
class LogObstacle extends MoveableObstacle {
  boolean isCrocodile; // maybe make (another) separate class?, there's also those bot-thingies

  public LogObstacle(Texture t, float x, float y, float w, float h, boolean isCrocodile) {
    super(t, x, y, w, h);
  }
  
}

// i.e. ?
class StaticObstacle extends Obstacle {
  public StaticObstacle(Texture t, float x, float y, float w, float h) {
    super(t, x, y, w, h);
  }
}
