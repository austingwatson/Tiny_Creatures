extends TileMap

enum Tile {
	GREEN,
	RED,
}


func _ready():
	randomize()


func set_tile(global_position: Vector2, tile: int):
	var local_position = self.to_local(global_position)
	var map_position = self.world_to_map(local_position)
	set_cell(map_position.x, map_position.y, tile)
	

func get_tile(global_position: Vector2):
	var local_position = self.to_local(global_position)
	var map_position = self.world_to_map(local_position)
	return get_cell(map_position.x, map_position.y)
