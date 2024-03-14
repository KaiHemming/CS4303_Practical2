class Infectious extends Hunter {
  final color PRIMARY_COLOUR = #9400FF;
  int VISION_TIME = 0;
  
  void render() {
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
  }
  
  void onTargetCollision() {
    for (Human h:stage.humans) {
      int[] targetCoords = h.getTilePos();
      int[] curCoords = getTilePos();
      if (targetCoords[0] == curCoords[0] & targetCoords[1] == curCoords[1]) {
        h.isDead = true;
        Infected infected = new Infected(targetCoords);
        stage.addEntity(infected);
      }
    }
  }
}
