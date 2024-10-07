extends "res://scripts/state_machine/state.gd"

const slug_stats = preload("res://resources/slug_stats/slug_stats.tres")

var slug
var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("dead")
	timer.start(slug_stats.get_random_dead_time())
	

func leave():
	timer.stop()



func _on_Timer_timeout():
	slug.queue_free()
