extends Node2D

signal task_done
signal task_failed
signal reset

onready var base_layer = $BaseLayer
onready var purple_layer = $PurpleLayer
onready var green_layer = $PurpleLayer
onready var red_layer = $PurpleLayer
onready var yellow_layer = $PurpleLayer
onready var new_tile_sound = $NewTileSound
onready var change_tile_sound = $ChangeTileSound


func _ready():
	randomize()
	

func _process(_delta):
	fix_layer(purple_layer)
	fix_layer(green_layer)
	fix_layer(red_layer)
	fix_layer(yellow_layer)
				

func fix_layer(layer: TileMap):
	var size = layer.get_used_rect().size / 2
	for i in range(-size.x, size.x):
		for j in range(-size.y, size.y):
			if layer.get_cell(i, j) != 2:
				continue
			var good = (get_tile_count_2x2_tl(layer, i, j) == 3) or (get_tile_count_2x2_tr(layer, i, j) == 3) or (get_tile_count_2x2_bl(layer, i, j) == 3) or (get_tile_count_2x2_br(layer, i, j) == 3)
			if not good:
				layer.set_cell(i, j, -1)
				

func get_tile_count_2x2_tl(layer: TileMap, x: int, y: int):
	var count = 0
	
	if layer.get_cell(x - 1, y - 1) == 2:
		count += 1
	if layer.get_cell(x, y - 1) == 2:
		count += 1
	if layer.get_cell(x - 1, y) == 2:
		count += 1
	
	return count


func get_tile_count_2x2_tr(layer: TileMap, x: int, y: int):
	var count = 0
	
	if layer.get_cell(x, y - 1) == 2:
		count += 1
	if layer.get_cell(x + 1, y - 1) == 2:
		count += 1
	if layer.get_cell(x + 1, y) == 2:
		count += 1
	
	return count
	

func get_tile_count_2x2_bl(layer: TileMap, x: int, y: int):
	var count = 0
	
	if layer.get_cell(x - 1, y) == 2:
		count += 1
	if layer.get_cell(x - 1, y + 1) == 2:
		count += 1
	if layer.get_cell(x, y + 1) == 2:
		count += 1
	
	return count
	

func get_tile_count_2x2_br(layer: TileMap, x: int, y: int):
	var count = 0
	
	if layer.get_cell(x + 1, y) == 2:
		count += 1
	if layer.get_cell(x + 1, y + 1) == 2:
		count += 1
	if layer.get_cell(x, y + 1) == 2:
		count += 1
	
	return count


func set_tile_on(global_position: Vector2, layer: int):
	match layer:
		Tile.Layer.PURPLE:
			set_purple_tile(global_position, 2)


func set_tile_off(global_position: Vector2, layer: int):
	match layer:
		Tile.Layer.PURPLE:
			set_purple_tile(global_position, -1)
			

func set_purple_tile(global_position: Vector2, tile: int):
	var cell = get_purple_cell(global_position)
	if cell == Tile.Base.NONE:
		new_tile_sound.play()
		tile_changed(Tile.Layer.PURPLE)
	elif tile != cell:
		change_tile_sound.play()
		tile_changed(Tile.Layer.PURPLE)
	set_purple_cell(global_position, tile)


func tile_changed(layer: int):
	pass
	

func get_tile(global_position: Vector2, layer: int):
	match layer:
		Tile.Layer.BASE:
			return get_base_cell(global_position)
		Tile.Layer.PURPLE:
			return get_purple_cell(global_position)
			

func is_tile_set(global_position: Vector2, layer: int):
	match layer:
		Tile.Layer.BASE:
			return false
		Tile.Layer.PURPLE:
			return get_purple_cell(global_position) == 2
	

func get_base_cell(global_position: Vector2):
	var local_position = base_layer.to_local(global_position)
	var map_position = base_layer.world_to_map(local_position)
	return base_layer.get_cell(map_position.x, map_position.y)
	

func get_purple_cell(global_position: Vector2):
	var local_position = purple_layer.to_local(global_position)
	var map_position = purple_layer.world_to_map(local_position)
	return purple_layer.get_cell(map_position.x, map_position.y)
	

func set_cell_2x2(global_position: Vector2, layer: TileMap, tile: int):
	var local_position = layer.to_local(global_position)
	var map_position = layer.world_to_map(local_position)
	layer.set_cell(map_position.x - 1, map_position.y - 1, tile)
	layer.set_cell(map_position.x, map_position.y - 1, tile)
	layer.set_cell(map_position.x - 1, map_position.y, tile)
	layer.set_cell(map_position.x, map_position.y, tile)
	layer.update_bitmask_region(map_position - Vector2(-1, -1), map_position)


func set_cell_3x3(global_position: Vector2, layer: TileMap, tile: int):
	var local_position = layer.to_local(global_position)
	var map_position = layer.world_to_map(local_position)
	layer.set_cell(map_position.x - 1, map_position.y - 1, tile)
	layer.set_cell(map_position.x, map_position.y - 1, tile)
	layer.set_cell(map_position.x + 1, map_position.y - 1, tile)
	layer.set_cell(map_position.x - 1, map_position.y, tile)
	layer.set_cell(map_position.x, map_position.y, tile)
	layer.set_cell(map_position.x + 1, map_position.y, tile)
	layer.set_cell(map_position.x - 1, map_position.y + 1, tile)
	layer.set_cell(map_position.x, map_position.y + 1, tile)
	layer.set_cell(map_position.x + 1, map_position.y + 1, tile)
	layer.update_bitmask_region(map_position - Vector2(-1, -1), map_position + Vector2(1, 1))
	

func set_purple_cell(global_position: Vector2, tile: int):
	if tile == 2:
		set_cell_2x2(global_position, purple_layer, tile)
	else:
		set_cell_3x3(global_position, purple_layer, tile)
	


func get_petri_dish(entities):
	#var size = layer1.get_used_rect().size
	#var tiles = []
	#for i in range(size.x):
	#	tiles.append([])
	#	for _j in range(size.y):
	#		tiles[i].append(0)
	
	#for entity in entities:
	#	var local_position = layer1.to_local(entity.global_position)
	#	var map_position = layer1.world_to_map(local_position) + (size / 2)
	#	map_position = Vector2(floor(map_position.x), floor(map_position.y))
	#	tiles[map_position.x][map_position.y] = entity.creature
	#
	return [[]]


func all_tasks_done():
	var close_lid_animation = $CloseLidAnimation
	hide_hud()
	close_lid_animation.start_animation()
	yield(close_lid_animation, "done")
	emit_signal("task_done")


func any_task_failed():
	var burn_animation = $BurnAnimation
	hide_hud()
	burn_animation.start_animation()
	yield(burn_animation, "done")
	emit_signal("task_failed")


func reset_level():
	var burn_animation = $BurnAnimation
	hide_hud()
	burn_animation.start_animation()
	yield(burn_animation, "done")
	emit_signal("reset")
	

func hide_hud():
	get_parent().hud.visible = false
	for task in get_tree().get_nodes_in_group("task"):
		task.visible = false


func _on_BurnAnimation_lid_down():
	get_parent().entity_manager.visible = false
	#layer2.visible = false
