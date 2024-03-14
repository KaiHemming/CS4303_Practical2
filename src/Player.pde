class Player {
  final int LIVES = 1;
  final int SIZE = 20;
  final color PRIMARY_COLOUR = #07D5DE;
  final color SECONDARY_COLOUR = #B2B0B0;
  final int SPEED = 3;
  int invincibilityTime = 100;
  int invincibilityTimer = 0;
  int lives = 1; //TODO: lives
  PVector position = new PVector();
  PVector velocity = new PVector();
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<Quadrant> exploredQuadrants = new ArrayList<Quadrant>();
  ArrayList<Corridor> exploredCorridors = new ArrayList<Corridor>();
  float bulletSpeed = 8f;
  int shootCooldown = 20;
  int curShootCooldown = 20;
  void reset() {
    lives = LIVES;
    exploredQuadrants.clear();
    exploredCorridors.clear();
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
        if (collisionObject instanceof Entity) {
          ((Entity)collisionObject).destroy();
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
    if (invincibilityTimer > 0) {
      fill(SECONDARY_COLOUR);
    } else {
      fill(PRIMARY_COLOUR);
    }
    stroke(1);
    circle(position.x, position.y, SIZE);
    
    if (curShootCooldown > 0) curShootCooldown--;
    if (invincibilityTimer > 0) invincibilityTimer--;
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
    if (stage.grid[y][x].hazard != null) {
      if (takeDamage()) stage.grid[y][x].hazard.delete();
    }
    if (stage.grid[y][x].isFloor) {
      if (stage.grid[y][x].quadrant != null) {
        if (!exploredQuadrants.contains(stage.grid[y][x].quadrant)) exploredQuadrants.add(stage.grid[y][x].quadrant);
      }
      if (stage.grid[y][x].corridors.size() != 0) {
        for (Corridor c: stage.grid[y][x].corridors) {
          exploredCorridors.add(c);
        }
      }
      if (stage.grid[y][x].powerUp != null) {
        if (stage.grid[y][x].powerUp.isUsed == false) {
          stage.grid[y][x].powerUp.effect();
        }
      }
      return true;
    }
    return false;
  }
  int[] getTilePos() {
    return new int[] {(int)position.x/stage.TILE_SIZE,(int)position.y/stage.TILE_SIZE};
  }
  void shoot(PVector direction) {
    if (curShootCooldown > 0) return;
    Bullet bullet = new Bullet(position, new PVector(direction.x*bulletSpeed, direction.y*bulletSpeed));
    bullets.add(bullet);
    curShootCooldown = shootCooldown;
  }
  boolean takeDamage() {
    if (invincibilityTimer <= 0) {
      lives--;
      if (lives <= 0) {
        hasLost = true;
      }
      invincibilityTimer = invincibilityTime;
      return true;
    }
    return false;
  }
}
