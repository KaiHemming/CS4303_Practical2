class Teen extends Human {
  final int SIZE = 15;
  final int SCORE_VALUE = 250;
  
  void render() {
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
  }
}
