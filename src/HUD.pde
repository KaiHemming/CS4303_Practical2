final class HUD {
  final int Y_PADDING = 5;
  final int FONT_SIZE = 64;
  final color PRIMARY_COLOUR = #07D5DE;
  final int WAVE_INDICATOR_TIME = 300;
  int waveIndicatorTime = 0;
  String waveMessage;
  int score; 
  Player player;
  
  HUD(Player player) {
    this.player = player;
  }
  
  void reset() {
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
    if (player.lives > 1) {
      text(player.lives + " Lives", displayWidth/2, FONT_SIZE + Y_PADDING);
    } else {
      text(player.lives + " Life Remaining!", displayWidth/2, FONT_SIZE + Y_PADDING);
    }
    if (waveIndicatorTime > 0) {
      fill(PRIMARY_COLOUR, 80);
      textSize(FONT_SIZE*2);
      textAlign(CENTER, CENTER);
      text(waveMessage, displayWidth/2, displayHeight/2);
      waveIndicatorTime--;
    }
  }
  
  // Starts wave indicator timer and changes message to be displayed.
  // Added after first playtest.
  void indicateWaveEnd(String waveMessage) {
    this.waveMessage = waveMessage;
    waveIndicatorTime = WAVE_INDICATOR_TIME;
  }
}
