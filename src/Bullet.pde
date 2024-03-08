class Bullet {
  final float DRAG_MODIFIER = 0.995;
  final color PRIMARY_COLOUR = #FF0000;
  final int SIZE = 10;
  PVector position;
  PVector velocity;
  Bullet(PVector position, PVector velocity) {
    this.position = position.copy();
    this.velocity = velocity;
  }
  boolean draw() {
    if (hasCollided() != null) return true;
    velocity.mult(DRAG_MODIFIER);
    position.add(velocity);
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
    return false;
  }
  Object hasCollided() {
    int x = (int)position.x/stage.TILE_SIZE;
    int y = (int)position.y/stage.TILE_SIZE;
    if (!stage.grid[y][x].isFloor) {
      return stage.grid[y][x];
    }
    return null;
  }
}
