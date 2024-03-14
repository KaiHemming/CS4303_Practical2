class Hazard {
  final int SCORE_VALUE = 5;
  final color COLOUR = #FF6E1A;
  Tile tile;
  Hazard(Tile tile) {
    this.tile = tile;
  }
  void delete() {
    tile.destroyHazard();
  }
  void destroy() {
    hud.score += SCORE_VALUE;
    delete();
  }
}
