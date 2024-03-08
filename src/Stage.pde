import java.util.Collections;

class Stage {
  final int TILE_SIZE = displayHeight/52;
  final int ROWS = floor(displayHeight/TILE_SIZE);
  final int COLS = floor(displayWidth/TILE_SIZE);
  final double SPLIT_HORIZONTAL_CHANCE = 0.5;
  final int MIN_HEIGHT = displayHeight/4;
  final int MIN_WIDTH = displayWidth/5;
  ArrayList<Quadrant> quadrants = new ArrayList<Quadrant>();
  Tile[][] grid = new Tile[ROWS][COLS];
  
  Stage(int numQuadrants) {
    print("rows: " + ROWS + ", cols: " + COLS + "\n");
    for (int r = 0; r < ROWS; r++ ) {
      for (int c = 0; c < COLS; c++) {
        Tile t = new Tile(c, r, TILE_SIZE);
        grid[r][c] = t;
      }
    }
    
    Quadrant q = new Quadrant(0,0, displayWidth, displayHeight, this);
    quadrants.add(q);
    for (int i=0; i < numQuadrants; i++) {
      boolean hasSpawned = false;
      while (!hasSpawned) {
        int qIndex = (int)random(quadrants.size());
        Quadrant splitQuadrant = quadrants.get(qIndex);
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
    }
    for(Quadrant quadrant: quadrants) {
      quadrant.debug();
    }
  }
  
  void draw() {
    for (Quadrant q: quadrants) {
      q.draw();
    }
    for (Tile[] row: grid) {
      for (Tile tile: row) {
        if (tile != null) {
          tile.draw();
        }
      }
    }
  }
}
