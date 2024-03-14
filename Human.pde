class Human extends Entity {
  final color PRIMARY_COLOUR = #DA71E0;
  int SCORE_VALUE = 200;
  boolean isRescued = false;
  
  void render() {
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
  }
  
  // TODO: Flee
  void patrol() {
  }
  
  void onPlayerCollision() {
    isRescued = true;
    destroy();
  }
}
