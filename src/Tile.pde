class Tile {
  color DEFAULT_COLOUR = 255;
  int x, y;
  int absoluteX, absoluteY;
  int size;
  color colour = DEFAULT_COLOUR;
  boolean isFloor = false;
  Hazard hazard;
  
  Tile(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
    absoluteX = x * size;
    absoluteY = y * size;
  }
  void destroyHazard() {
    this.colour = DEFAULT_COLOUR;
    hazard = null;
  }
  void setColour(color colour) {
    this.colour = colour;
  }
  void setIsFloor(boolean isFloor) {
    this.isFloor = isFloor;
  }
  boolean isHazard() {
    if (hazard == null) {
      return false;
    }
    return true;
  }
  void draw() {
    if (isFloor) {
      fill(colour);
    } else {
      noFill();
    }
    stroke(0,30);
    rect(absoluteX, absoluteY, size, size);
  }
}
