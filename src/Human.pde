class Human extends Entity {
  final color PRIMARY_COLOUR = #DA71E0;
  final int SCORE_VALUE = 100;
  boolean isRescued = false;
  
  void render() {
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
  }
  
  void onPlayerCollision() {
    isRescued = true;
    destroy();
  }
}
