class Human extends Entity {
  final color PRIMARY_COLOUR = #DA71E0;
  final int SCORE_VALUE = 10;
  final int FLEE_DIST = 8;
  boolean isRescued = false;
  AStarSearch fleePathFinder = new AStarSearch(stage.grid);
  ArrayList<AStarNode> fleePath;
  boolean flee = false;
  
  Human() {
    super();
    primaryColour = PRIMARY_COLOUR;
    scoreValue = SCORE_VALUE;
  }
  
  void patrol() {
    if (flee()) {
      flee = true;
    } else {
      flee = false;
      super.patrol();
    }
  }
  
  void render() {
    strokeWeight(2);
    if (flee) {
      stroke(#FF0000);
    } else {
      stroke(255);
    }
    fill(primaryColour);
    circle(position.x, position.y, size);
    strokeWeight(1);
    noStroke();
  }
  
  int[] getFleeTargetCoords() {
    boolean found = false;
    int[] targetCoords = new int[2];
    for (Entity e:stage.robots) {
      if (e instanceof Hunter | e instanceof Infectious) {
        int[] eCoords = e.getTilePos();
        int[] curCoords = getTilePos();
        if (dist(curCoords[0], curCoords[1], targetCoords[0], targetCoords[1]) > dist(curCoords[0], curCoords[1], eCoords[0], eCoords[1])) {
          found = true;
          targetCoords[0] = eCoords[0];
          targetCoords[1] = eCoords[1];
        }
      }
    }
    if (found) return targetCoords;
    return null;
  }
  
  boolean flee() {
    int[] curCoords = getTilePos();
    int[] targetCoords = getFleeTargetCoords();
    if (targetCoords == null) return false;
    fleePath = null;
    try {
      fleePath = fleePathFinder.search(curCoords[1], curCoords[0], targetCoords[1], targetCoords[0]);
    } catch (NullPointerException e) {
      System.out.println("Null pointer when searching for human flee path");
      return false;
    }
    if (fleePath == null) return false;
    if (fleePath.size() <= FLEE_DIST) {
      fleeMovement();
      return true;
    }
    for (int i = 0; i < targetCoords.length; i+=2) {
      Tile curTile = stage.grid[curCoords[1]][curCoords[0]];
      Tile targetTile = stage.grid[targetCoords[i+1]][targetCoords[i]];
      if (curTile.quadrant != null & targetTile.quadrant != null) {
        if (curTile.quadrant == targetTile.quadrant) {
          fleeMovement();
          return true;
        }
      }
      if (curTile.corridors.size() != 0 & targetTile.corridors.size() != 0) {
        for (Corridor c:targetTile.corridors) {
          if (curTile.corridors.contains(c)) {
            fleeMovement();
            return true;
          }
        }
      }
    }
    return false;
  }
  
  void fleeMovement() {
    if (isDead) {
      return;
    }
    if (fleePath == null | fleePath.size() < 2) return;
    
    // If touching player
    if (path == null) return;
    if (path.size() <= 1) {
      onTargetCollision();
      return;
    }

    // Kinematic movement based on next node in A*
    AStarNode nextNode = fleePath.get(0);
    int nextRow = nextNode.getRow();
    int nextCol = nextNode.getCol();
    int[] currentCoords = getTilePos();
    int curRow = currentCoords[1];
    int curCol = currentCoords[0];
    PVector targetVel = new PVector(nextCol - curCol, nextRow - curRow);
    
    // Integrate
    velocity = targetVel;
    velocity.normalize();
    velocity.mult(speed).mult(-1);
    PVector newPosition = position.copy();
    newPosition.add(velocity);
    
    orientation = atan2(velocity.y, velocity.x);
    
    if (!isWalkable(newPosition)) {
      //position.add(velocity.mult(-1));
      return;
    } 
    
    position.add(velocity);
  }
  
  void move() {
    if (flee()) {
      flee = true;
    } else {
      flee = false;
      super.move();
    }
  }
  
  void onTargetCollision() {
    isRescued = true;
    destroy();
  }
}
