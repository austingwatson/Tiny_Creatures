extends Node2D

signal dead

var level

onready var timer = $Timer


func _ready():
	timer.stop()


func _process(_delta):
	if level.get_tile(global_position, Tile.Layer.BASE) == Tile.Base.HURT:
		if timer.is_stopped():
			timer.start()
	else:
		timer.stop()


func _on_Timer_timeout():
	emit_signal("dead")
