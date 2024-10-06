extends Node2D

signal task_done
signal task_failed

onready var layer1 = $Layer1
onready var layer2 = $Layer2
onready var new_tile_sound = $NewTileSound
onready var change_tile_sound = $ChangeTileSound
onready var task = $Task


func _ready():
	randomize()


func set_tile(global_position: Vector2, tile: int):
	var local_position = layer2.to_local(global_position)
	var map_position = layer2.world_to_map(local_position)
	var cell = layer2.get_cell(map_position.x, map_position.y)
	if cell == Tile.NONE:
		new_tile_sound.play()
		if tile == Tile.SLUG_TRAIL:
			task.add_current(1)
	elif tile != cell:
		change_tile_sound.play()
		if tile == Tile.SLUG_TRAIL:
			task.add_current(1)
	layer2.set_cell(map_position.x, map_position.y, tile)
	

func get_tile(global_position: Vector2):
	var layer2_cell = get_layer2_cell(global_position)
	if layer2_cell >= 0:
		return layer2_cell
	
	return get_layer1_cell(global_position)
	

func get_layer1_cell(global_position: Vector2):
	var local_position = layer1.to_local(global_position)
	var map_position = layer1.world_to_map(local_position)
	return layer1.get_cell(map_position.x, map_position.y)
	

func get_layer2_cell(global_position: Vector2):
	var local_position = layer2.to_local(global_position)
	var map_position = layer2.world_to_map(local_position)
	return layer2.get_cell(map_position.x, map_position.y)


func get_petri_dish(entities):
	var size = layer1.get_used_rect().size
	var tiles = []
	for i in range(size.x):
		tiles.append([])
		for _j in range(size.y):
			tiles[i].append(0)
	
	for entity in entities:
		var local_position = layer1.to_local(entity.global_position)
		var map_position = layer1.world_to_map(local_position) + (size / 2)
		map_position = Vector2(floor(map_position.x), floor(map_position.y))
		tiles[map_position.x][map_position.y] = entity.creature
	
	return tiles


func _on_Task_task_done():
	emit_signal("task_done")


func _on_Task_task_failed():
	emit_signal("task_failed")
