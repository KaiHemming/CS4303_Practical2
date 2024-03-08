// Game Elements
boolean hasLost;
boolean hasStarted = false;
//LoseScreen loseScreen = new LoseScreen();
TitleScreen titleScreen = new TitleScreen();
Stage stage;

void setup() {
  fullScreen();
  noCursor();
  stage = new Stage(4);
}
void reset() {
  stage = new Stage(4);
}
void render() {
  background(0);
  stage.draw();
}
// Render graphics
void draw() {
  //if (hasLost) {
  //  loseScreen.draw();
  //} else if (!hasStarted) {
  //  titleScreen.draw();
  //}
  //else {
  //  render();
  //}
  render();
}
void keyPressed() {
  switch (key) {
    case 'w':
      break;
    case ' ':
      print("reset\n");
      reset();
      break;
  }
}
