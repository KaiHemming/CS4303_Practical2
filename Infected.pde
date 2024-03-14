class Infected extends Entity {
  Infected(int[] pos) {
    super();
    setPos(pos[0]*stage.TILE_SIZE + stage.TILE_SIZE/2, pos[1]*stage.TILE_SIZE + stage.TILE_SIZE/2);
  }
}
