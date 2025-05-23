class Tile {
  static final color DEFAULT_COLOUR = 255;
  Quadrant quadrant;
  ArrayList<Corridor> corridors = new ArrayList<Corridor>();
  int x, y;
  int absoluteX, absoluteY;
  int size;
  color colour = DEFAULT_COLOUR;
  boolean isFloor = false;
  PowerUp powerUp;
  Hazard hazard;
  
  Tile(int x, int y, int size) {
    this.x = x;
    this.y = y;
    this.size = size;
    absoluteX = x * size;
    absoluteY = y * size;
  }
  void destroyHazard() {
    this.colour = DEFAULT_COLOUR;
    hazard = null;
  }
  void setColour(color colour) {
    this.colour = colour;
  }
  void setIsFloor(boolean isFloor, Quadrant quadrant) {
    this.quadrant = quadrant;
    this.isFloor = isFloor;
  }
  void setIsFloor(boolean isFloor, Corridor corridor) {
    this.isFloor = isFloor;
    if (this.quadrant == null) {
      corridors.add(corridor);
    }
  }
  boolean isHazard() {
    if (hazard == null) {
      return false;
    }
    return true;
  }
  void draw() {
    noFill();
    if (isFloor) {
      if (player.exploredQuadrants.contains(quadrant)) {
        if (quadrant == stage.spawnQuadrant) {
          fill(#86FFA7);
        } else fill(colour);
      }
      else {
        fill(colour,100);
      }
      for (Corridor c: corridors) {
        if (player.exploredCorridors.contains(c)) {
          fill(colour);
        }
        else {
          fill(colour,100);
        }
      }
    } 
    if (hazard != null) {
      fill(hazard.COLOUR);
    }
    stroke(0,30);
    rect(absoluteX, absoluteY, size, size);
    if (powerUp != null) {
      if (powerUp.isUsed == false) {
        powerUp.draw();
      }
    }
    if (DEBUG) {
      if (quadrant != null) {
        fill(quadrant.colour,100);
        rect(absoluteX, absoluteY, size, size);
      }
      if (corridors.size() != 0) {
        for (Corridor c:corridors) {
          fill(c.colour,100);
          rect(absoluteX, absoluteY, size, size);
        }
      }
    }
  }
}
