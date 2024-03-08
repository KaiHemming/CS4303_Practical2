class Stage {
  final int TILE_SIZE = 100;
  ArrayList<Quadrant> quadrants = new ArrayList<Quadrant>();
  Tile[][] grid;
  
  Stage(int rows, int cols, int numQuadrants) {
      Quadrant q = new Quadrant(0,0, displayWidth, displayHeight, this);
      quadrants.add(q);
      for (int i=0; i < numQuadrants; i++) {
        int qIndex = (int)random(quadrants.size());
        Quadrant splitQuadrant = quadrants.get(qIndex);
        if ((int)random(2) == 0) {
          quadrants.add(splitQuadrant.splitVertical());
        } else {
          quadrants.add(splitQuadrant.splitHorizontal());
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
  }
}
