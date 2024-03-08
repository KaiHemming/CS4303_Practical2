// Game Elements
boolean hasLost;
boolean hasStarted = false;
//LoseScreen loseScreen = new LoseScreen();
TitleScreen titleScreen = new TitleScreen();
Stage stage;
Player player;
HUD hud;

// Movement
boolean isMovingLeft = false;
boolean isMovingRight = false;
boolean isMovingUp = false;
boolean isMovingDown = false;

void setup() {
  fullScreen();
  noCursor();
  stage = new Stage(10, 7);
  player = new Player(stage);
  hud = new HUD(player);
  stage.placePlayer(player);
}
void reset() {
  stage = new Stage(10, 7);
  player = new Player(stage);
  hud = new HUD(player);
  stage.placePlayer(player);
}
void render() {
  background(0);
  stage.draw();
  hud.draw();
  if (isMovingLeft) {
    player.moveLeft();
  }
  if (isMovingRight) {
    player.moveRight();
  }
  if (isMovingUp) {
    player.moveUp();
  }
  if (isMovingDown) {
    player.moveDown();
  }
  player.draw();
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
      isMovingUp = true;
      break;
    case 'a':
      isMovingLeft = true;
      break;
    case 's':
      isMovingDown = true;
      break;
    case 'd':
      isMovingRight = true;
      break;
  }
}
void keyReleased() {
  switch (key) {
    case 'w':
      isMovingUp = false;
      break;
    case 'a':
      isMovingLeft = false;
      break;
    case 's':
      isMovingDown = false;
      break;
    case 'd':
      isMovingRight = false;
      break;
    case ' ':
      reset();
      break;
  }
}
