class Robot {
  final color PRIMARY_COLOUR = #FF0000;
  final int SIZE = 20;
  PVector position = new PVector();
  PVector velocity = new PVector();
  
  void setPos(int x, int y) {
    position.x = x;
    position.y =y;
  }
  
  void draw() {
    fill(PRIMARY_COLOUR);
    circle(position.x, position.y, SIZE);
  }
}
