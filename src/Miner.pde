final class Miner {
  ArrayList<Corridor> dig(ArrayList<Quadrant> quadrants, Stage stage) {
    ArrayList<Corridor> halls = new ArrayList<Corridor>();
    //IntList indexes = new IntList();
    //for (int i = 0; i < quadrants.size(); i++) {
    //  indexes.append(i);
    //}
    //indexes.shuffle();
    //for (int index:indexes) {
    //}
    for (int i = 0; i < quadrants.size(); i++) {
      Quadrant startQuadrant = quadrants.get(i);
      Quadrant goalQuadrant;
      // Randomly determines tile's quadrant in corridors 
      //Quadrant tileClassifications; 
      if (i == quadrants.size()-1) {
        goalQuadrant = quadrants.get(i-1);
      } else {
        goalQuadrant = quadrants.get(i+1);
      }
      //if ((int)random(0,2) == 0) {
      //  tileClassifications = startQuadrant;
      //} else {
      //  tileClassifications = goalQuadrant;
      //}
      int startX = startQuadrant.x + startQuadrant.width/2;
      int startY = startQuadrant.y + startQuadrant.height/2;
      int goalX = goalQuadrant.x + goalQuadrant.width/2;
      int goalY = goalQuadrant.y + goalQuadrant.height/2;
      float distance = dist(startX, startY, goalX, goalY);

      print("mining from " + startX + ", " + startY + " to " + goalX + ", " + goalY + "\n");
      Corridor hall = new Corridor();
      halls.add(hall);
      if (startX > goalX) {
        for (int x = startX; x > goalX; x--) {
          digXDirection(goalY, x, stage, hall);
        }
      } else {
        for (int x = startX; x < goalX; x++) {
          digXDirection(goalY, x, stage, hall);
        }
      }
      if (startY > goalY) {
        for (int y = startY; y > goalY; y--) {
          digYDirection(y, startX, stage, hall);
        }
      } else {
        for (int y = startY; y < goalY; y++) {
          digYDirection(y, startX, stage, hall);
        }
      }
    }
    System.out.println("numHalls: " + halls.size());
    return halls;
  }
  void digXDirection(int goalY, int x, Stage stage, Corridor hall) {
    stage.grid[goalY-1][x].setIsFloor(true, hall);
    hall.addTile(stage.grid[goalY-1][x]);
    stage.grid[goalY][x].setIsFloor(true, hall);
    hall.addTile(stage.grid[goalY][x]);
    stage.grid[goalY+1][x].setIsFloor(true, hall);
    hall.addTile(stage.grid[goalY+1][x]);
  }
  void digYDirection(int y, int startX, Stage stage, Corridor hall) {
    stage.grid[y][startX-1].setIsFloor(true, hall);
    hall.addTile(stage.grid[y][startX-1]);
    stage.grid[y][startX].setIsFloor(true, hall);
    hall.addTile(stage.grid[y][startX]);
    stage.grid[y][startX+1].setIsFloor(true, hall);
    hall.addTile(stage.grid[y][startX+1]);
  }
}
