class Human extends Entity {
  final color PRIMARY_COLOUR = #DA71E0;
  final int SCORE_VALUE = 10;
  boolean isRescued = false;
  AStarSearch pathFinder = new AStarSearch(stage.grid);
  ArrayList<AStarNode> path;
  boolean flee = false;
  
  Human() {
    super();
    primaryColour = PRIMARY_COLOUR;
    scoreValue = SCORE_VALUE;
  }
  
  // TODO: Flee
  void patrol() {
    super.patrol();
  }
  
  void flee() {
  }
  
  void move() {
    if (flee) flee();
    else super.move();
  }
  
  void onTargetCollision() {
    isRescued = true;
    destroy();
  }
}
