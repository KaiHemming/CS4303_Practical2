class Tile {
  int x, y;
  int absoluteX, absoluteY;
  int size;
  
  Tile(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
    absoluteX = x * size;
    absoluteY = y * size;
  }
  void draw() {
    noFill();
    stroke(0);
    rect(absoluteX, absoluteY, size, size);
  }
}
