extends "res://scripts/state_machine/state.gd"

const scary_boy_stats = preload("res://resources/scary_boy_stats/scary_boy_stats.tres")

var scary_boy
var animated_sprite: AnimatedSprite
var splat

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("dead")
	timer.start(scary_boy_stats.get_random_dead_time())
	splat.play()
	

func leave():
	timer.stop()


func _on_Timer_timeout():
	scary_boy.queue_free()
