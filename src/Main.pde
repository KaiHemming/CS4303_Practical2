// Set to true for debug mode, draws paths and areas, allows reset with spacebar
final boolean DEBUG = false;
// Game Elements
boolean hasLost = false;
boolean hasStarted = false;
LoseScreen loseScreen = new LoseScreen();
TitleScreen titleScreen = new TitleScreen();
Stage stage;
Player player;
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
int waveNumber = 1;
int numHumans = 1;
int numRobots = 2;
int numHunters = 0;
int numInfectious = 0;
int INITIAL_NUM_HUMANS = numHumans;
int INITIAL_NUM_ROBOTS = numRobots;
int INITIAL_NUM_HUNTERS = numHunters;
int INITIAL_NUM_INFECTIOUS = numInfectious;
double powerUpChance = 0.3;

void setup() {
  fullScreen();
  noCursor();
  player = new Player();
  stage = new Stage(8, 5, powerUpChance);
  hud = new HUD(player);
  stage.spawnWave(numRobots, numHumans, numHunters, numInfectious);
}
// Resets game
void reset() {
  numHumans = INITIAL_NUM_HUMANS;
  numRobots = INITIAL_NUM_ROBOTS;
  numHunters = INITIAL_NUM_HUNTERS;
  numInfectious = INITIAL_NUM_INFECTIOUS;
  waveNumber = 0;
  hud.reset();
  player.reset();
  nextWave();
}
// Spawns next wave and regenerates stage.
void nextWave() {
  player.bullets.clear();
  waveNumber++;
  stage = new Stage(10, 7, powerUpChance);
  numRobots = constrain(numRobots+2, INITIAL_NUM_ROBOTS, 40);
  numHumans = constrain(numHumans + waveNumber%2, INITIAL_NUM_HUMANS, 5);
  numHunters = constrain(numHunters + waveNumber%2, INITIAL_NUM_HUNTERS, 5);
  numInfectious = constrain(numInfectious + waveNumber%3, INITIAL_NUM_INFECTIOUS, 7);
  System.out.println("WAVE DATA\n");
  System.out.println("numRobots: " + numRobots + ", numHumans: " + numHumans + ", numHunters: " + numHunters + ", numInfectious: " + numInfectious);
  stage.spawnWave(numRobots, numHumans, numHunters, numInfectious);
  hud.indicateWaveEnd("Wave " + waveNumber);
}
// Handle movement and draw game
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
}
// Manage key press
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
// Manage key press
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
        } else if (hasLost) {
          hasLost = false;
          reset();
        } else {
          hasLost = false;
          if (DEBUG) reset();
        }
        break;
    }
  }
}
