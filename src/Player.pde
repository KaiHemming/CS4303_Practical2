class Player {
  final int MAX_LIVES = 3;
  final int SIZE = 20;
  final color PRIMARY_COLOUR = #07D5DE;
  final int SPEED = 5;
  Stage stage;
  int lives = 3; //TODO:
  PVector position = new PVector();
  PVector velocity = new PVector();
  Player(Stage stage) {
    this.stage = stage;
  }
  void reset() {
    lives = MAX_LIVES;
  }
  void setPos(int x, int y) {
    position.x = x;
    position.y = y;
  }
  void moveUp() {
    velocity.y -= SPEED;
  }
  void moveDown() {
    velocity.y += SPEED;
  }
  void moveLeft() {
    velocity.x -= SPEED;
  }
  void moveRight() {
    velocity.x += SPEED;
  }
  void draw() {
    PVector nextPos = new PVector(position.x, position.y);
    nextPos.add(velocity);
    if (isWalkable(nextPos)) {
      position = nextPos;
    }
    velocity.mult(0);
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
  }
  boolean isWalkable(PVector pos) {
    int x = (int)pos.x/stage.TILE_SIZE;
    int y = (int)pos.y/stage.TILE_SIZE;
    if (stage.grid[y][x].isFloor) {
      return true;
    }
    //x = floor(pos.x/stage.TILE_SIZE);
    //y = floor(pos.y/stage.TILE_SIZE);
    //if (stage.grid[y][x].isFloor) {
    //  return true;
    //}
    return false;
  }
}
