class Hazard {
  final color COLOUR = #FFA005;
  Tile tile;
  Hazard(Tile tile) {
    this.tile = tile;
    tile.setColour(COLOUR);
  }
  void destroy() {
    tile.destroyHazard();
  }
}
