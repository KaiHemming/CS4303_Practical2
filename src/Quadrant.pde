class Quadrant {
  Stage stage;
  int x, y;
  int width, height;
  color colour; 
  Quadrant(int x, int y, int width, int height, Stage stage) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.stage = stage;
    colour = color(random(256),random(256),random(256));
  }
  void debug() {
    print("x: " + x + ", y: " + y + ", width: " + width + ", height: " + height + "\n");
  }
  void draw() {
    //line(x, y, x + width, y + height);
    fill(colour,200);
    rect(x,y, width, height);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("width " + width + " height " + height, x + width/2, y + height/2);
  }
  Quadrant splitHorizontal() {
    print("horizontal split ");
    debug();
    int newWidth = width/2;
    this.width = newWidth;
    Quadrant q = new Quadrant(x + width, y, newWidth, height, stage);
    return q;
  }
  Quadrant splitVertical() {
    print("vertical split ");
    debug();
    int newHeight = height/2;
    this.height = newHeight;
    Quadrant q = new Quadrant(x, y + newHeight, width, newHeight, stage);
    return q;
  }
}
