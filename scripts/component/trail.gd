extends Node2D

export var layer = 0

var level
var can_make_trail = false


func _physics_process(_delta):
	if can_make_trail and level.get_tile(global_position, Tile.Layer.BASE) != Tile.Base.STERILE:
		#yield(get_tree().create_timer(0.25), "timeout")
		level.set_tile_on(global_position, layer)
