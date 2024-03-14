final class HUD {
  final int Y_PADDING = 5;
  final int FONT_SIZE = 64;
  final color PRIMARY_COLOUR = #07D5DE;
  int score; 
  Player player;
  
  HUD(Player player) {
    this.player = player;
  }
  
  void reset() {
    player.lives = player.MAX_LIVES;
    score = 0;
  }
  
  // TODO: Draw lives and scoring
  void draw() {
      // Score and wave number
    fill(PRIMARY_COLOUR);
    textSize(FONT_SIZE);
    textAlign(CENTER, TOP);
    text(score, displayWidth/2, Y_PADDING);
    textSize(FONT_SIZE/2);
    text(player.lives + " lives", displayWidth/2, FONT_SIZE + Y_PADDING);
  }
}
