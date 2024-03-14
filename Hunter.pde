// TODO: Bug where it will detect humans in another quadrant.
class Hunter extends Entity {
  final color PRIMARY_COLOUR = #FC8208;
  int VISION_TIME = 0;
  
  void render() {
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
  }
  
  int[] getTargetCoords() {
    ArrayList<Integer> targetCoordsList = new ArrayList<Integer>();
    for (Human h:stage.humans) {
      int[] coords = h.getTilePos();
      targetCoordsList.add(coords[0]);
      targetCoordsList.add(coords[1]);
    }
    int[] targetCoords = new int[targetCoordsList.size()];
    if (targetCoords.length == 0) {
      return super.getTargetCoords();
    }
    for (int i = 0; i < targetCoords.length; i++) {
      targetCoords[i] = targetCoordsList.get(i);
    }
    return targetCoords;
  }
  
  void onTargetCollision() {
    for (Human h:stage.humans) {
      int[] targetCoords = h.getTilePos();
      int[] curCoords = getTilePos();
      if (targetCoords[0] == curCoords[0] & targetCoords[1] == curCoords[1]) {
        h.isDead = true;
      }
    }
  }
}
