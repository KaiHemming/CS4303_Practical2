class Child extends Human {
  final int SIZE = 10;
  int SCORE_VALUE = 300;
  
  void render() {
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
  }
}
