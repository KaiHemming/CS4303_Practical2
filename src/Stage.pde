import java.util.Collections;

class Stage {
  final int TILE_SIZE = displayHeight/52;
  final int ROWS = floor(displayHeight/TILE_SIZE);
  final int COLS = floor(displayWidth/TILE_SIZE);
  final double SPLIT_LARGER_QUADRANT_CHANCE = 0.7;
  final double SPLIT_HORIZONTAL_CHANCE = 0.5;
  final int MIN_HEIGHT = ROWS/6;
  final int MIN_WIDTH = COLS/8;
  Quadrant spawnQuadrant;
  ArrayList<Quadrant> quadrants = new ArrayList<Quadrant>();
  ArrayList<Robot> robots = new ArrayList<Robot>();
  Tile[][] grid = new Tile[ROWS][COLS];
  
  Stage(int numSplits, int numRooms) {
    print("rows: " + ROWS + ", cols: " + COLS + "\n");
    print("minheight: " + MIN_HEIGHT + ", minwidth: " + MIN_WIDTH + "\n");
    for (int r = 0; r < ROWS; r++ ) {
      for (int c = 0; c < COLS; c++) {
        Tile t = new Tile(c, r, TILE_SIZE);
        grid[r][c] = t;
      }
    }
    
    Quadrant q = new Quadrant(0,0, COLS, ROWS, this);
    quadrants.add(q);
    for (int i=0; i < numSplits; i++) {
      boolean hasSpawned = false;
      while (!hasSpawned) {
        int qIndex = (int)random(floor((quadrants.size())/2));
        Quadrant splitQuadrant; 
        if ((int)random(101) <= SPLIT_LARGER_QUADRANT_CHANCE * 100) {
          splitQuadrant = quadrants.get(qIndex + floor((quadrants.size())/2));
        } else {
          splitQuadrant = quadrants.get(qIndex);
        }
        if (splitQuadrant.height/2 < MIN_HEIGHT & splitQuadrant.width/2 < MIN_WIDTH) {
          continue;
        }
        if (splitQuadrant.height/2 < MIN_HEIGHT) {
          quadrants.add(splitQuadrant.splitHorizontal());
          hasSpawned = true;
          break;
        }
        if (splitQuadrant.width/2 < MIN_WIDTH) {
          quadrants.add(splitQuadrant.splitVertical());
          hasSpawned = true;
          break;
        }
        if ((int)random(101) <= SPLIT_HORIZONTAL_CHANCE * 100) {
          quadrants.add(splitQuadrant.splitHorizontal());
          hasSpawned = true;
        } else {
          quadrants.add(splitQuadrant.splitVertical());
          hasSpawned = true;
        }
      }
      Collections.sort(quadrants);
    }
    while(quadrants.size() > numRooms) {
      //quadrants.remove((int)random(quadrants.size()));
      quadrants.remove(0); // Remove smallest first
    }
    for(Quadrant quadrant: quadrants) {
      quadrant.debug();
      quadrant.placeRoom();
    }
    Miner.dig(quadrants, this);
    print("done\n");
  }
  
  void placePlayer(Player player) {
    spawnQuadrant = quadrants.get((int)random(quadrants.size()));
    player.setPos(spawnQuadrant.x*TILE_SIZE + spawnQuadrant.width*TILE_SIZE/2, spawnQuadrant.y*TILE_SIZE + spawnQuadrant.height*TILE_SIZE/2);
  }
  
  void placeRobot(Robot robot) {
    Quadrant q = spawnQuadrant;
    int x = q.x;
    int y = q.y;
    while (q == spawnQuadrant) {
      q = quadrants.get((int)random(quadrants.size()));
      Tile tile = q.tiles.get((int)random(q.tiles.size()));
      x = tile.absoluteX + TILE_SIZE/2;
      y = tile.absoluteY + TILE_SIZE/2;
    }
    robot.setPos(x, y);
    print("placed robot x: " + x + ", y: " + y + "\n");
  }
  
  void spawnWave(int numRobots) {
    for (int i = 0; i < numRobots; i++) {
      Robot robot = new Robot();
      placeRobot(robot);
      robots.add(robot);
    }
  }
  
  void draw() {
    for (Tile[] row: grid) {
      for (Tile tile: row) {
        if (tile != null) {
          tile.draw();
        }
      }
    }
    for (Robot robot:robots) {
      robot.draw();
    }
    for(Quadrant q:quadrants) {
      q.draw();
    }
  }
}
