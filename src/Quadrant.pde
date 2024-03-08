class Quadrant implements Comparable<Quadrant>{
  Stage stage;
  int x, y;
  int width, height;
  int size;
  color colour; 
  Quadrant(int x, int y, int width, int height, Stage stage) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    size = width * height;
    this.stage = stage;
    colour = color(random(256),random(256),random(256));
  }
  @Override public int compareTo(Quadrant o) {
    if (this.size > o.size) return 1;
    else if (this.size < o.size) return -1;
    else return 0;
  }
  
  void debug() {
    print("x: " + x + ", y: " + y + ", width: " + width + ", height: " + height + "\n");
  }
  void draw() {
    fill(colour,200);
    rect(x,y, width, height);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(20);
    text("width " + width + " height " + height, x + width/2, y + height/2);
  }
  Quadrant splitHorizontal() {
    int newWidth = width/2;
    this.width = newWidth;
    Quadrant q = new Quadrant(x + width, y, newWidth, height, stage);
    return q;
  }
  Quadrant splitVertical() {
    int newHeight = height/2;
    this.height = newHeight;
    Quadrant q = new Quadrant(x, y + newHeight, width, newHeight, stage);
    return q;
  }
}
