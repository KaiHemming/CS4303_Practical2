class Entity {
  final int SCORE_VALUE = -50;
  final color PRIMARY_COLOUR = #FF0000;
  final int SIZE = 20;
  final int SPEED = 1;
  final int VISION_DIST = 8;
  final int REACTION_SPEED = 3;
  final int VISION_TIME = 300;
  boolean detectedPlayer = false;
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
  
  void draw() {
    detectedPlayer = detectPlayer();
    if (pathFindingCountDown <= 0) {
      clearPath();
      int[] robotCoords = getTilePos();
      int[] playerCoords = player.getTilePos();
      ArrayList<AStarNode> result = pathFinder.search(robotCoords[1], robotCoords[0], playerCoords[1], playerCoords[0]);
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
  
  boolean detectPlayer() {
    if (path != null) {
      if (path.size() <= VISION_DIST) {
        visionCountDown = VISION_TIME;
        return true;
      }
    }
    int[] robotCoords = getTilePos();
    int[] playerCoords = player.getTilePos();
    Tile robotTile = stage.grid[robotCoords[1]][robotCoords[0]];
    Tile playerTile = stage.grid[playerCoords[1]][playerCoords[0]];
    if (robotTile.quadrant != null & playerTile.quadrant != null) {
      if (robotTile.quadrant == playerTile.quadrant) {
        visionCountDown = VISION_TIME;
        return true;
      }
    }
    if (robotTile.corridors.size() != 0 & playerTile.corridors.size() != 0) {
      for (Corridor c:playerTile.corridors) {
        if (robotTile.corridors.contains(c)) {
          visionCountDown = VISION_TIME;
          return true;
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
  
  void onPlayerCollision() {
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
      onPlayerCollision();
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
