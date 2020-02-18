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

  float xs;
  // no ys, at least not yet
}

class CarObstacle extends MoveableObstacle {
  public CarObstacle(Texture t, float x, float y, float w, float h) {
    super(t, x, y, w, h);
  }
  // the cars
}

class LogObstacle extends MoveableObstacle {
  boolean isCrocodile; // maybe make (another) separate class?, there's also those bot-thingies

  public LogObstacle(Texture t, float x, float y, float w, float h) {
    super(t, x, y, w, h);
  }
}

class StaticObstacle extends Obstacle {
  public StaticObstacle(Texture t, float x, float y, float w, float h) {
    super(t, x, y, w, h);
  }
}
