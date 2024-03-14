class Entity {
  int SCORE_VALUE = 50;
  final color PRIMARY_COLOUR = #FF0000;
  final int SIZE = 20;
  final int SPEED = 1;
  final int VISION_DIST = 8;
  final int REACTION_SPEED = 3;
  final int VISION_TIME = 300;
  boolean detectedTarget = false;
  boolean isDead = false;
  PVector position = new PVector();
  PVector velocity = new PVector();
  AStarSearch pathFinder = new AStarSearch(stage.grid);
  ArrayList<AStarNode> path;
  int pathFindingCountDown = REACTION_SPEED;
  int visionCountDown;
  
  void setPos(int x, int y) {
    position.x = x;
    position.y = y;
  }
  
  void render() {
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
  }
  
  int[] getTargetCoords() {
    return player.getTilePos();
  }
  
  void draw() {
    detectedTarget = detectTarget();
    // TODO: Move inside detectTarget
    if (pathFindingCountDown <= 0) {
      clearPath();
      int[] robotCoords = getTilePos();
      int[] targetCoords = getTargetCoords();
      ArrayList<AStarNode> result = pathFinder.search(robotCoords[1], robotCoords[0], targetCoords[1], targetCoords[0]);
      if (result != null) {
        path = result;
      } else {
        path = null;
      }
      pathFindingCountDown = REACTION_SPEED;
    }
    if (DEBUG) {
      if (path != null) {
        for (AStarNode node:path) {
          stage.grid[node.getRow()][node.getCol()].setColour(color(#FFA7A7));
        }
      }
    }
    if (visionCountDown > 0) move();
    else patrol();
    render();
    pathFindingCountDown--;
    if (visionCountDown > 0) visionCountDown--;
  }
  
  boolean detectTarget() {
    if (path != null) {
      if (path.size() <= VISION_DIST) {
        visionCountDown = VISION_TIME;
        return true;
      }
    }
    int[] curCoords = getTilePos();
    int[] targetCoords = getTargetCoords();
    for (int i = 0; i < targetCoords.length; i+=2) {
      Tile curTile = stage.grid[curCoords[1]][curCoords[0]];
      Tile targetTile = stage.grid[targetCoords[i+1]][targetCoords[i]];
      if (curTile.quadrant != null & targetTile.quadrant != null) {
        if (curTile.quadrant == targetTile.quadrant) {
          visionCountDown = VISION_TIME;
          return true;
        }
      }
      if (curTile.corridors.size() != 0 & targetTile.corridors.size() != 0) {
        for (Corridor c:targetTile.corridors) {
          if (curTile.corridors.contains(c)) {
            visionCountDown = VISION_TIME;
            return true;
          }
        }
      }
    }
    return false;
  }
  
  void destroy() {
    isDead = true;
    hud.score += SCORE_VALUE;
    clearPath();
  }
  
  void patrol() {
  }
  
  void onTargetCollision() {
    if (player.takeDamage()) {
      destroy();
    }
  }
  
  void move() {
    if (isDead) {
      return;
    }
    if (path == null) return;
    if (path.size() == 1) {
      onTargetCollision();
      return;
    }
    AStarNode nextNode = path.get(path.size()-2);
    int nextRow = nextNode.getRow();
    int nextCol = nextNode.getCol();
    int[] currentCoords = getTilePos();
    int curRow = currentCoords[1];
    int curCol = currentCoords[0];
    //System.out.println("nextRow: " + nextRow + ", nextCol: " + nextCol + ", curRow: " + curRow + ", curCol: " + curCol);
    if (curRow < nextRow) {
      moveDown();
    } else if (curRow > nextRow) {
      moveUp();
    }
    if (curCol < nextCol) {
      moveRight();
    } else if (curCol > nextCol) {
      moveLeft();
    }
  }
  void moveUp() {
    position.y -= SPEED;
  }
  void moveDown() {
    position.y += SPEED;
  }
  void moveLeft() {
    position.x -= SPEED;
  }
  void moveRight() {
    position.x += SPEED;
  }
  void clearPath() {
    if (path != null) {
      if(DEBUG) {
        for (AStarNode node:path) {
          stage.grid[node.getRow()][node.getCol()].setColour(Tile.DEFAULT_COLOUR);
        }
        path.clear();
      }
    }
  }
  
  int[] getTilePos() {
    return new int[] {(int)position.x/stage.TILE_SIZE,(int)position.y/stage.TILE_SIZE};
  }
  
  boolean hasCollided(PVector position) {
    if (dist(this.position.x, this.position.y, position.x, position.y) <= SIZE) return true;
    return false;
  }
}
