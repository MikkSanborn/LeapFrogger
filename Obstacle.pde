abstract class Obstacle {
  float x, y; // tile occuped, top left
  int w, h; // usually 1x1
  
  color c; // or texture
  Texture t;
  
  void display() {
    noStroke();
    fill(c);
    rect(x, y, w, h);
  }
}

class MoveableObstacle extends Obstacle {
  float xs;
  // no ys, at least not yet
}

class CarObstacle extends MoveableObstacle {
  // the cars
}

class LogObstacle extends MoveableObstacle {
  boolean isCrocodile; // maybe make (another) separate class?
}

class StaticObstacle extends Obstacle {
  
}
