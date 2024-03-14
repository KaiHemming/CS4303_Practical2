class PowerUp {
  final color INVINCIBILITY_COLOUR = #BC5FFF;
  final color BOMB_COLOUR = #5F0300;
  final int SIZE = stage.TILE_SIZE/2;
  int type = 0; // 0 is Invincibility, 1 is Gain life
  int x, y;
  
  PowerUp(int x, int y) {
    type = int(random(0,2));
    this.x = x;
    this.y = y;
  }
  void draw() {
    if (type == 0) {
      fill(INVINCIBILITY_COLOUR);
    } else {
      fill(BOMB_COLOUR);
    }
    rect(x + SIZE, y + SIZE, SIZE, SIZE);
  }
  void effect() {
    if (type == 0) {
      player.invincibilityTimer = player.invincibilityTime * 2;
    } else {
      player.lives++;
    }
    destroy();
  }
  void destroy() {
  }
}
