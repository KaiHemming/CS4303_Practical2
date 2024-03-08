class Player {
  final int MAX_LIVES = 3;
  final int SIZE = 20;
  final color PRIMARY_COLOUR = #07D5DE;
  final int SPEED = 5;
  int lives = 3; //TODO: lives
  PVector position = new PVector();
  PVector velocity = new PVector();
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  float bulletSpeed = 8f;
  int shootCooldown = 20;
  int curShootCooldown = 20;
  void reset() {
    lives = MAX_LIVES;
  }
  void setPos(int x, int y) {
    position.x = x;
    position.y = y;
  }
  void draw() {
    ArrayList<Bullet> removeBullets = new ArrayList<Bullet>();
    for (Bullet bullet: bullets) {
      Object collisionObject = bullet.draw();
      if (collisionObject != null) {
        removeBullets.add(bullet);
        if (collisionObject instanceof Hazard) {
          Hazard h = (Hazard)collisionObject;
          h.destroy();
        }
      }
    }
    bullets.removeAll(removeBullets);
    PVector nextPos = new PVector(position.x, position.y);
    nextPos.add(velocity);
    if (isWalkable(nextPos)) {
      position = nextPos;
    }
    velocity.mult(0);
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
    
    if (curShootCooldown > 0) curShootCooldown--;
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
  boolean isWalkable(PVector pos) {
    int x = (int)pos.x/stage.TILE_SIZE;
    int y = (int)pos.y/stage.TILE_SIZE;
    if (stage.grid[y][x].isFloor) {
      return true;
    }
    return false;
  }
  void shoot(PVector direction) {
    if (curShootCooldown > 0) return;
    Bullet bullet = new Bullet(position, new PVector(direction.x*bulletSpeed, direction.y*bulletSpeed));
    bullets.add(bullet);
    curShootCooldown = shootCooldown;
  }
}
