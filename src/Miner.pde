final static class Miner {
  static void dig(ArrayList<Quadrant> quadrants, Stage stage) {
    //IntList indexes = new IntList();
    //for (int i = 0; i < quadrants.size(); i++) {
    //  indexes.append(i);
    //}
    //indexes.shuffle();
    //for (int index:indexes) {
    //}
    for (int i = 0; i < quadrants.size(); i++) {
      int startX = quadrants.get(i).x + quadrants.get(i).width/2;
      int startY = quadrants.get(i).y + quadrants.get(i).height/2;
      int goalX, goalY;
      if (i == quadrants.size()-1) {
        goalX = quadrants.get(i-1).x + quadrants.get(i-1).width/2;
        goalY = quadrants.get(i-1).y + quadrants.get(i-1).height/2;
      } else {
        goalX = quadrants.get(i+1).x + quadrants.get(i+1).width/2;
        goalY = quadrants.get(i+1).y + quadrants.get(i+1).height/2;
      }
      print("mining from " + startX + ", " + startY + " to " + goalX + ", " + goalY + "\n");
      if (startX > goalX) {
        for (int x = startX; x > goalX; x--) {
          stage.grid[goalY-1][x].setIsFloor(true);
          stage.grid[goalY][x].setIsFloor(true);
          stage.grid[goalY+1][x].setIsFloor(true);
        }
      } else {
        for (int x = startX; x < goalX; x++) {
          stage.grid[goalY-1][x].setIsFloor(true);
          stage.grid[goalY][x].setIsFloor(true);
          stage.grid[goalY+1][x].setIsFloor(true);
        }
      }
      if (startY > goalY) {
        for (int y = startY; y > goalY; y--) {
          stage.grid[y][startX-1].setIsFloor(true);
          stage.grid[y][startX].setIsFloor(true);
          stage.grid[y][startX+1].setIsFloor(true);
        }
      } else {
        for (int y = startY; y < goalY; y++) {
          stage.grid[y][startX-1].setIsFloor(true);
          stage.grid[y][startX].setIsFloor(true);
          stage.grid[y][startX+1].setIsFloor(true);
        }
      }
    }
  }
}
