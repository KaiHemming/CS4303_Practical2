final boolean DEBUG = false;
// Game Elements
boolean hasLost = false;
boolean hasStarted = false;
LoseScreen loseScreen = new LoseScreen();
TitleScreen titleScreen = new TitleScreen();
Stage stage;
Player player = new Player();
HUD hud;

// Movement
boolean isMovingLeft = false;
boolean isMovingRight = false;
boolean isMovingUp = false;
boolean isMovingDown = false;

// Shooting
boolean isShootingLeft = false;
boolean isShootingRight = false;
boolean isShootingUp = false;
boolean isShootingDown = false;

// Wave Data
int numHumans = 1;
int numRobots = 2;
int numHunters = 1;
int numInfectious = 1;
int INITIAL_NUM_HUMANS = numHumans;
int INITIAL_NUM_ROBOTS = numRobots;
int INITIAL_NUM_HUNTERS = numHunters;
int INITIAL_NUM_INFECTIOUS = numInfectious;
double powerUpChance = 0.3;

void setup() {
  fullScreen();
  noCursor();
  stage = new Stage(8, 5, powerUpChance);
  hud = new HUD(player);
  stage.spawnWave(numRobots, numHumans, numHunters, numInfectious);
}
void reset() {
  numHumans = INITIAL_NUM_HUMANS;
  numRobots = INITIAL_NUM_ROBOTS;
  numHunters = INITIAL_NUM_HUNTERS;
  numInfectious = INITIAL_NUM_INFECTIOUS;
  hud.reset();
  player.reset();
  nextWave();
}
void nextWave() {
  stage = new Stage(10, 7, powerUpChance);
  stage.spawnWave(numRobots, numHumans, numHunters, numInfectious);
}
void render() {
  background(0);
  if (stage.draw()) nextWave();
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
  PVector shootDirection = new PVector();
  if (isShootingLeft) {
    shootDirection.x -= 1;
  }
  if (isShootingRight) {
    shootDirection.x += 1;
  }
  if (isShootingUp) {
    shootDirection.y -= 1;
  }
  if (isShootingDown) {
    shootDirection.y += 1;
  }
  if (shootDirection.mag() != 0) {
    player.shoot(shootDirection);
  }
  player.draw();
}
// Render graphics
void draw() {
  if (hasLost) {
    loseScreen.draw();
  } else if (!hasStarted) {
    titleScreen.draw();
  }
  else {
    render();
  }
  //render();
}
void keyPressed() {
  if (key == CODED) {
    switch(keyCode) {
      case UP:
        isShootingUp = true;
        break;
      case DOWN:
        isShootingDown = true;
        break;
      case LEFT:
        isShootingLeft = true;
        break;
      case RIGHT:
        isShootingRight = true;
    }
  }
  else {
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
}
void keyReleased() {
  if (key == CODED) {
    switch(keyCode) {
      case UP:
        isShootingUp = false;
        break;
      case DOWN:
        isShootingDown = false;
        break;
      case LEFT:
        isShootingLeft = false;
        break;
      case RIGHT:
        isShootingRight = false;
    }
  }
  else {
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
        if (!hasStarted) {
          hasStarted = true;
        } else {
          hasLost = false;
          reset();
        }
        break;
    }
  }
}
