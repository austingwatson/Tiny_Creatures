extends "res://scripts/state_machine/state.gd"

const slug_stats = preload("res://resources/slug_stats/slug_stats.tres")

var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	timer.start(slug_stats.get_random_idle_time())
	animated_sprite.play("idle")
	

func leave():
	timer.stop()


func _on_Timer_timeout():
	state_machine.enter_state("Move")
