class PowerUp {
  final color INVINCIBILITY_COLOUR = #BC5FFF;
  final color LIFE_UP_COLOUR = #24980B;
  final int SIZE = displayHeight/52/2;
  boolean isUsed = false;
  int type = 0; // 0 is Invincibility, 1 is Gain life
  int x, y;
  Tile tile;
  
  PowerUp(int x, int y, Tile tile) {
    type = int(random(0,2));
    this.x = x;
    this.y = y;
    System.out.println("Placed powerup x: " + x + ", y: " + y);
  }
  void draw() {
    if (type == 0) {
      fill(INVINCIBILITY_COLOUR);
    } else {
      fill(LIFE_UP_COLOUR);
    }
    rect(x + SIZE/2, y + SIZE/2, SIZE, SIZE);
    noFill();
  }
  void effect() {
    if (type == 0) {
      player.invincibilityTimer = player.invincibilityTime * 3;
    } else {
      player.lives++;
    }
    isUsed = true;
  }
}
