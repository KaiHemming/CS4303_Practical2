class Quadrant implements Comparable<Quadrant> {
  boolean spawnedHuman = false;
  final double HAZARD_CHANCE = 0.01;
  Stage stage;
  int x, y;
  int absoluteX, absoluteY;
  int width, height;
  int absoluteWidth, absoluteHeight;
  int size;
  color colour;
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  
  Quadrant(int x, int y, int width, int height, Stage stage) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    size = width * height;
    this.stage = stage;
    absoluteX = x * stage.TILE_SIZE;
    absoluteY = y * stage.TILE_SIZE;
    colour = color(random(256),random(256),random(256));
  }
  @Override public int compareTo(Quadrant o) {
    if (this.size > o.size) return 1;
    else if (this.size < o.size) return -1;
    else return 0;
  }
  void debug() {
    print("x: " + x + ", y: " + y + ", width: " + width + ", height: " + height + "\n");
  }
  void draw() {
    noFill();
    stroke(255,100);
    rect(absoluteX, absoluteY, width*stage.TILE_SIZE, height*stage.TILE_SIZE);
    noStroke();
  }
  Quadrant splitHorizontal() {
    int newWidth = width/2;
    this.width = newWidth;
    Quadrant q = new Quadrant(x + width, y, newWidth, height, stage);
    return q;
  }
  Quadrant splitVertical() {
    int newHeight = height/2;
    this.height = newHeight;
    Quadrant q = new Quadrant(x, y + newHeight, width, newHeight, stage);
    return q;
  }
  // TODO: Place rooms at different points in quadrant 
  void placeRoom() {
    int marginWidth = constrain(width/10, 3, 5);
    int marginHeight = constrain(height/10, 3, 5);
    for (int curX = x + marginWidth; curX < x + width - marginWidth; curX++) {
      for (int curY = y + marginHeight; curY < y + height - marginHeight; curY++) {
        Tile tile =  stage.grid[curY][curX];
        tile.setIsFloor(true, this);
        if (random(101) <= HAZARD_CHANCE * 100) tile.hazard = new Hazard(tile);
        tiles.add(tile);
      }
    }
  }
  boolean isInQuadrant(PVector position) {
    System.out.println("posX: " + position.x + ", posY: " + position.y + ", absoluteX: " + absoluteX + ", absoluteY: " + absoluteY + ", height: " + height + ", width: " + width);
    if (position.x >= absoluteX & position.x <= absoluteX + width*stage.TILE_SIZE) {
      if (position.y >= absoluteY & position.y <= absoluteY + height*stage.TILE_SIZE) {
        return true;
      }
    }
    return false;
  }
  void placePowerUp() {
    Tile t = tiles.get((int)random(0,tiles.size()));
    t.powerUp = new PowerUp(t.absoluteX, t.absoluteY, t);
  }
}
