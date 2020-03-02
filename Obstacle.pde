// super type for all obstacles seen
abstract class Obstacle {
  float x, y; // tile occuped, top left
  float w, h; // usually 1x1
  float logX;
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
  
  void displayDebug() {
    noStroke();
    fill(80, 80, 255, 100);
    rect(x, y, w, h);
  }
}

abstract class MoveableObstacle extends Obstacle {
  float x_bound; // the boundary of the x where the car should "teleport" back to the other side.

  public MoveableObstacle(Texture t, float x, float y, float w, float h, float xs, float x_bound) {
    super(t, x, y, w, h);
    this.xs = xs;
    this.x_bound = x_bound;
  }
  
  public void move() {
    super.x+=xs;
    
    if (super.x > 500/*+x_bound*/) { // remove the x_bound part, just to make it simpler
      super.x = -x_bound;
    } else if (super.x/*+super.w*/ < -x_bound) {
      super.x = 500/*+x_bound*/; // remove x_bound to match above
    }
    // don't actually set to -x_bound
    // if x>x_bound, x = -x_bound
  }

  float xs;
  // no ys, at least not yet
}

// car
class CarObstacle extends MoveableObstacle {
  float xs;
  
  public CarObstacle(Texture t, float x, float y, float w, float h, float xs, float x_bound) {
    super(t, x, y, w, h, xs, x_bound);
    this.xs = xs;
    this.x_bound = x_bound;
  }
  
  // the cars
}

// a moving log, can be a croco
class LogObstacle extends MoveableObstacle {

  public LogObstacle(Texture t, float x, float y, float w, float h, float xs, float x_bound) {
    super(t, x, y, w, h, xs, x_bound);
    logX = xs;
  }
  
}

class TurtleObstacle extends LogObstacle {
  // eventually make a blink out method.
  boolean blinksOut;
  
  public TurtleObstacle(Texture t, float x, float y, float w, float h, float xs, float x_bound, boolean blinksOut) {
    super(t, x, y, w, h, xs, x_bound);
    this.blinksOut = blinksOut;
  }
  
  public boolean canBlinkOut() {
    return blinksOut;
  }
  
  public boolean blinkOut() {
    if (!blinksOut) {
      return false;
    } else {
      super.t.nextFrame();
      
      return true;
    }
  }
  
  public void move() {
    super.move();
    
    // if it has started to blink out, and it's been 5 frames since last update
    if (super.t.currentFrameNum() != 0 && frameCount%5 == 0) {
      super.t.nextFrame(); // sink it
      if (super.t.currentFrameNum() == 0) { // if this has gone through the full animation,
        super.x = getScreenPosX(-1); // remove from the screen; it has "sunken"
        super.y = getScreenPosY(-1);
        // --====----===---===---===---=--=-=-=-=-=-=-=-=-=-=-=-= ========  
        // >>> They need to still be there, just not "interactable". Keep them on screen, and have them reappear,
        // but don't forget that the reverse sequence needs to be shown to "reappear" them
      }
    }
  }
  
}
