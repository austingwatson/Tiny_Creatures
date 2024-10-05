extends Node2D

var level


func _physics_process(_delta):
	level.set_tile(global_position, 1)
