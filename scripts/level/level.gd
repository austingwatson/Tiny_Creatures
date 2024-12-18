extends Node2D

signal task_done
signal task_failed
signal reset

var task_done = false

onready var base_layer = $BaseLayer
onready var purple_layer = $PurpleLayer
onready var green_layer = $GreenLayer
onready var red_layer = $RedLayer
onready var yellow_layer = $YellowLayer
onready var new_tile_sound = $NewTileSound
onready var change_tile_sound = $ChangeTileSound


func _ready():
	randomize()
	
	$Walls.visible = true
	$BurnAnimation.visible = true
	$CloseLidAnimation.visible = true
	
	var size = base_layer.get_used_rect().size / 2
	for i in range(-size.x, size.x):
		for j in range(-size.y, size.y):
			if base_layer.get_cell(i, j) == 2:
				var killer_tile = preload("res://scenes/component/killer_tile.tscn").instance()
				killer_tile.position = base_layer.map_to_world(Vector2(i, j)) + Vector2(8, 8)
				add_child(killer_tile)
	

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
	layer.update_dirty_quadrants()
				

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
		Tile.Layer.GREEN:
			set_green_tile(global_position, 2)
		Tile.Layer.RED:
			set_red_tile(global_position, 2)
		Tile.Layer.YELLOW:
			set_yellow_tile(global_position, 2)


func set_tile_off(global_position: Vector2, layer: int):
	match layer:
		Tile.Layer.PURPLE:
			set_purple_tile(global_position, -1)
		Tile.Layer.GREEN:
			set_green_tile(global_position, -1)
		Tile.Layer.RED:
			set_red_tile(global_position, -1)
		Tile.Layer.YELLOW:
			set_yellow_tile(global_position, -1)
			

func set_purple_tile(global_position: Vector2, tile: int):
	var cell = get_purple_cell(global_position)
	if tile != cell:
		change_tile_sound.play()
		if tile == 2:
			tile_set(Tile.Layer.PURPLE)
			add_particle(global_position, preload("res://scenes/component/floor_splat_purple.tscn"), purple_layer)
		elif tile == -1:
			tile_unset(Tile.Layer.PURPLE)
	set_cell_2x2(global_position, purple_layer, tile)
	

func set_green_tile(global_position: Vector2, tile: int):
	var cell = get_green_cell(global_position)
	if tile != cell:
		change_tile_sound.play()
		if tile == 2:
			tile_set(Tile.Layer.GREEN)
		elif tile == -1:
			tile_unset(Tile.Layer.GREEN)
	set_cell_2x2(global_position, green_layer, tile)
	

func set_red_tile(global_position: Vector2, tile: int):
	var cell = get_red_cell(global_position)
	if tile != cell:
		change_tile_sound.play()
		if tile == 2:
			tile_set(Tile.Layer.RED)
		elif tile == -1:
			tile_unset(Tile.Layer.RED)
	set_cell_2x2(global_position, red_layer, tile)
	

func set_yellow_tile(global_position: Vector2, tile: int):
	var cell = get_yellow_cell(global_position)
	if tile != cell:
		change_tile_sound.play()
		if tile == 2:
			tile_set(Tile.Layer.YELLOW)
		elif tile == -1:
			tile_unset(Tile.Layer.YELLOW)
	set_cell_2x2(global_position, yellow_layer, tile)
	

func add_particle(global_position, particle_scene, layer):
	var local_position = layer.to_local(global_position)
	var map_position = layer.world_to_map(local_position)
	var particle = particle_scene.instance()
	particle.position = layer.map_to_world(map_position) + Vector2(8, 8)
	add_child(particle)


func tile_set(_layer: int):
	pass
	

func tile_unset(_layer: int):
	pass
	

func get_tile(global_position: Vector2, layer: int):
	match layer:
		Tile.Layer.BASE:
			return get_base_cell(global_position)
		Tile.Layer.PURPLE:
			return get_purple_cell(global_position)
		Tile.Layer.GREEN:
			return get_green_cell(global_position)
		Tile.Layer.RED:
			return get_red_cell(global_position)
		Tile.Layer.YELLOW:
			return get_yellow_cell(global_position)
			

func is_tile_set(global_position: Vector2, layer: int):
	match layer:
		Tile.Layer.BASE:
			return false
		Tile.Layer.PURPLE:
			return get_purple_cell(global_position) == 2
		Tile.Layer.GREEN:
			return get_green_cell(global_position) == 2
		Tile.Layer.RED:
			return get_red_cell(global_position) == 2
		Tile.Layer.YELLOW:
			return get_yellow_cell(global_position) == 2
	

func get_base_cell(global_position: Vector2):
	var local_position = base_layer.to_local(global_position)
	var map_position = base_layer.world_to_map(local_position)
	return base_layer.get_cell(map_position.x, map_position.y)
	

func get_purple_cell(global_position: Vector2):
	var local_position = purple_layer.to_local(global_position)
	var map_position = purple_layer.world_to_map(local_position)
	return purple_layer.get_cell(map_position.x, map_position.y)
	

func get_green_cell(global_position: Vector2):
	var local_position = green_layer.to_local(global_position)
	var map_position = green_layer.world_to_map(local_position)
	return green_layer.get_cell(map_position.x, map_position.y)
	

func get_red_cell(global_position: Vector2):
	var local_position = red_layer.to_local(global_position)
	var map_position = red_layer.world_to_map(local_position)
	return red_layer.get_cell(map_position.x, map_position.y)
	

func get_yellow_cell(global_position: Vector2):
	var local_position = yellow_layer.to_local(global_position)
	var map_position = yellow_layer.world_to_map(local_position)
	return yellow_layer.get_cell(map_position.x, map_position.y)
	

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


func get_petri_dish(_entities):
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
	if task_done:
		return
	task_done = true
	
	$Victory.play()
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
	purple_layer.visible = false
	green_layer.visible = false
	red_layer.visible = false
	yellow_layer.visible = false
