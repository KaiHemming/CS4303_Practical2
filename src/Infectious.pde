class Infectious extends Hunter {
  color PRIMARY_COLOUR = #9400FF;
  int VISION_TIME = 1;
  
  Infectious() {
    super();
    primaryColour = PRIMARY_COLOUR;
    visionTime = VISION_TIME;
  }
  
  void onTargetCollision() {
    if (stage.humans.isEmpty()) {
      super.onTargetCollision();
    }
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
