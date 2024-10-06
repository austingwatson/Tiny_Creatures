extends Node2D

var level
var can_make_trail = false


func _physics_process(_delta):
	if can_make_trail and level.get_tile(global_position) != Tile.STERILE:
		#yield(get_tree().create_timer(0.25), "timeout")
		level.set_tile(global_position, Tile.SLUG_TRAIL)
