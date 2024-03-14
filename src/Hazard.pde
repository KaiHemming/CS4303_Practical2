class Hazard {
  final int SCORE_VALUE = 0;
  final color COLOUR = #FF0505;
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
