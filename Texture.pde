// A "frame_manager" class
class Texture {
  // take an array of input images, and display them based on the frame of the animation

  PImage[] frames;
  int frame;

  Texture(PImage[] frames) {
    this.frames = frames;
    this.frame = 0;
  }

  Texture(PImage frame) { // if is one frame
    this.frames = new PImage[1];
    this.frames[0] = frame;
    this.frame = 0;
  }

  PImage thisFrame() {
    return frames[frame];
  }

  PImage nextFrame() { // used to increment the frame number, and returns the next frame
    frame++;
    frame%=frames.length;
    return frames[frame];
  }

  PImage prevFrame() {
    frame = (frame-1 <= 0 ? frames.length-1:frame-1);
    return frames[frame];
  }

  PImage currentFrame() {
    return thisFrame();
  }

  PImage[] getFrames() {
    return frames;
  }
  
  int currentFrameNum() {
    return frame;
  }
  
  int numFrames() {
    return frames.length;
  }
}

enum Direction {
  Up, Down, Left, Right
}
