class Corridor {
  color colour;
  ArrayList<Tile> tiles = new ArrayList<Tile>();
  Corridor() {
    colour = color(random(256),random(256),random(256));
  }
  void addTile(Tile tile) {
    tiles.add(tile);
  }
}
