extends Node2D

signal task_done
signal task_failed
signal reset

onready var layer1 = $Layer1
onready var layer2 = $Layer2
onready var new_tile_sound = $NewTileSound
onready var change_tile_sound = $ChangeTileSound


func _ready():
	randomize()


func set_tile(global_position: Vector2, tile: int):
	var local_position = layer2.to_local(global_position)
	var map_position = layer2.world_to_map(local_position)
	var cell = layer2.get_cell(map_position.x, map_position.y)
	if cell == Tile.NONE:
		new_tile_sound.play()
		tile_changed(Tile.NONE, tile)
	elif tile != cell:
		change_tile_sound.play()
		tile_changed(cell, tile)
	layer2.set_cell(map_position.x, map_position.y, tile)


func tile_changed(_old_tile: int, _new_tile: int):
	pass
	

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


func all_tasks_done():
	var close_lid_animation = $CloseLidAnimation
	close_lid_animation.start_animation()
	yield(close_lid_animation, "done")
	emit_signal("task_done")
	print("level task done")


func any_task_failed():
	var burn_animation = $BurnAnimation
	burn_animation.start_animation()
	yield(burn_animation, "done")
	emit_signal("task_failed")


func reset_level():
	var burn_animation = $BurnAnimation
	burn_animation.start_animation()
	yield(burn_animation, "done")
	emit_signal("reset")


func _on_BurnAnimation_lid_down():
	get_parent().entity_manager.visible = false
	layer2.visible = false
