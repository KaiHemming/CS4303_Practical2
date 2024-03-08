class Tile {
  int x, y;
  int absoluteX, absoluteY;
  int size;
  boolean isFloor = false;
  
  Tile(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
    absoluteX = x * size;
    absoluteY = y * size;
  }
  void setIsFloor(boolean isFloor) {
    this.isFloor = isFloor;
  }
  void draw() {
    if (isFloor) {
      fill(255);
    } else {
      noFill();
    }
    stroke(0,30);
    rect(absoluteX, absoluteY, size, size);
  }
}
