class Entity {
  final int VISION_DIST = 8;
  final int SEARCH_UPDATE_SPEED = 2;
  final int VISION_TIME = 300;
  float orientation = random(0,360);
  int scoreValue = 1;
  color primaryColour = #FF0000;
  int size = displayHeight/52;
  float speed = 1.75;
  int visionTime = 300;
  boolean detectedTarget = false;
  boolean isDead = false;
  PVector position = new PVector();
  PVector velocity = new PVector();
  AStarSearch pathFinder = new AStarSearch(stage.grid);
  ArrayList<AStarNode> path;
  int pathFindingCountDown = SEARCH_UPDATE_SPEED;
  int visionCountDown;
  
  void setPos(int x, int y) {
    position.x = x;
    position.y = y;
  }
  
  void render() {
    fill(primaryColour);
    circle(position.x, position.y, size);
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
      //int[] targetCoords = getTargetCoords();
      int[] allTargetCoords = getTargetCoords();
      int[] targetCoords = new int[2];
      for (int i = 0; i < allTargetCoords.length; i+=2) {
        if (targetCoords[0] == 0) {
          targetCoords[0] = allTargetCoords[i];
          targetCoords[1] = allTargetCoords[i+1];
        } else {
          if (dist(robotCoords[1], robotCoords[0], targetCoords[1], targetCoords[0]) > dist(robotCoords[1], robotCoords[0], allTargetCoords[i], allTargetCoords[i+1])) {
            targetCoords[0] = allTargetCoords[i];
            targetCoords[1] = allTargetCoords[i+1];
          }
        }
      }
      try {
        ArrayList<AStarNode> result = pathFinder.search(robotCoords[1], robotCoords[0], targetCoords[1], targetCoords[0]);
        if (result != null) {
          path = result;
        } else {
          path = null;
        }
        pathFindingCountDown = SEARCH_UPDATE_SPEED;
      } catch (NullPointerException e) {
        System.out.println("Null pointer when searching for " + this + "'s path moving elsewhere");
        stage.placeEntity(this);
      }
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
  
  //void draw() {
  //  detectedTarget = detectTarget();
  //  // TODO: Move inside detectTarget
  //  if (pathFindingCountDown <= 0) {
  //    if (detectedTarget) {
  //      System.out.println("Detected!");
  //      patrolTarget = null;
  //      clearPath();
  //      int[] robotCoords = getTilePos();
  //      int[] allTargetCoords = getTargetCoords();
  //      int[] targetCoords = new int[2];
  //      for (int i = 0; i < allTargetCoords.length; i+=2) {
  //        if (targetCoords[0] == 0) {
  //          targetCoords[0] = allTargetCoords[i];
  //          targetCoords[1] = allTargetCoords[i+1];
  //        } else {
  //          if (dist(robotCoords[1], robotCoords[0], targetCoords[1], targetCoords[0]) > dist(robotCoords[1], robotCoords[0], allTargetCoords[i], allTargetCoords[i+1])) {
  //            targetCoords[0] = allTargetCoords[i];
  //            targetCoords[1] = allTargetCoords[i+1];
  //          }
  //        }
  //      }
  //      ArrayList<AStarNode> result = pathFinder.search(robotCoords[1], robotCoords[0], targetCoords[1], targetCoords[0]);
  //      if (result != null) {
  //        path = result;
  //      } else {
  //        path = null;
  //      }
  //      pathFindingCountDown = REACTION_SPEED;
  //    } else {
  //      //detectPatrolTarget();
  //    }
  //  }
  //  if (DEBUG) {
  //    if (path != null) {
  //      for (AStarNode node:path) {
  //        stage.grid[node.getRow()][node.getCol()].setColour(color(#FFA7A7));
  //      }
  //    }
  //  }
  //  move();
  //  //if (visionCountDown > 0) move();
  //  //else {
  //  //  //detectPatrolTarget();
  //  //  //move();
  //  //}
  //  render();
  //  pathFindingCountDown--;
  //  //if (visionCountDown > 0) visionCountDown--;
  //}
  
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
    hud.score += scoreValue;
    clearPath();
  }
  
  void patrol() {
    if (!isWalkable(position)) {
      if (path!=null) {
        position.x = path.get(path.size()).getCol() * stage.TILE_SIZE;
        position.y = path.get(path.size()).getRow() * stage.TILE_SIZE;
      }
    }
    velocity.x = cos(orientation);
    velocity.y = sin(orientation);
    velocity.mult(speed);
    
    PVector newPosition = position.copy();
    newPosition.add(velocity);
    
    if (!isWalkable(newPosition)) {
      orientation += PI/32;
      return;
    } 
    position.add(velocity);
    
    orientation += random(0, PI/64) - random(0, PI/64);
    
    if (orientation > PI) orientation -= 2*PI;
    else if(orientation < - PI) orientation += 2*PI;
  }
  
  boolean isWalkable(PVector pos) {
    int x = (int)pos.x/stage.TILE_SIZE;
    int y = (int)pos.y/stage.TILE_SIZE;
    if (stage.grid[y][x].isFloor & stage.grid[y][x].hazard == null) {
      return true;
    }
    return false;
  }
  
  //void detectPatrolTarget() {
  //  clearPath();
  //  //orientation += random(0, PI/64) - random(0, PI/64);
  //  //position.x += cos(orientation) * speed;
  //  //position.y += sin(orientation) * speed;
  //  Quadrant q = stage.quadrants.get((int)random(0,stage.quadrants.size()));
  //  int[] robotCoords = getTilePos();
  //  //while (!q.tiles.contains(stage.grid[robotCoords[1]][robotCoords[0]])) {
  //  //  q = stage.quadrants.get((int)random(0,stage.quadrants.size()));
  //  //}
  //  ArrayList<AStarNode> result;
  //  if (patrolTarget == null) {
  //    Tile target = q.tiles.get((int)random(0,q.tiles.size()));
  //    patrolTarget = target;
  //    result = pathFinder.search(robotCoords[1], robotCoords[0], target.x, target.y);
  //  } else {
  //    return;
  //    //result = pathFinder.search(robotCoords[1], robotCoords[0], patrolTarget.x, patrolTarget.y);
  //  }
  //  if (result != null) {
  //    path = result;
  //  } else {
  //    path = null;
  //  }
  //  pathFindingCountDown = REACTION_SPEED;
  //}
  
  void onTargetCollision() {
    if (player.takeDamage()) {
      System.out.println("HIT!");
      destroy();
    }
  }
  
  void move() {
    if (isDead) {
      return;
    }
    if (path == null) return;
    if (path.size() <= 1) {
      onTargetCollision();
      return;
    }
    // Kinematic movement based on next node in A*
    AStarNode nextNode = path.get(path.size()-2);
    int nextRow = nextNode.getRow();
    int nextCol = nextNode.getCol();
    int[] currentCoords = getTilePos();
    int curRow = currentCoords[1];
    int curCol = currentCoords[0];
    PVector targetVel = new PVector(nextCol - curCol, nextRow - curRow);
    
    // Integrate
    velocity = targetVel;
    velocity.normalize();
    velocity.mult(speed);
    position.add(velocity);
    
    orientation = atan2(velocity.y, velocity.x);
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
    if (dist(this.position.x, this.position.y, position.x, position.y) <= size) return true;
    return false;
  }
}
