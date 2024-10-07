extends "res://scripts/state_machine/state.gd"

const slime_stats = preload("res://resources/slime_stats/slime_stats.tres")

var slime
var animated_sprite: AnimatedSprite
var leave_slime = true

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("dead")
	timer.start(slime_stats.get_random_dead_time())
	

func leave():
	timer.stop()



func _on_Timer_timeout():
	if leave_slime:
		slime.level.set_tile_on(slime.global_position, Tile.Layer.GREEN)
	slime.queue_free()
