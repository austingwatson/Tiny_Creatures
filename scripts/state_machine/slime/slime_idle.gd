extends "res://scripts/state_machine/state.gd"

const slime_stats = preload("res://resources/slime_stats/slime_stats.tres")

var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	timer.start(rand_range(slime_stats.idle_time.x, slime_stats.idle_time.y))
	animated_sprite.play("idle")
	

func leave():
	timer.stop()


func _on_Timer_timeout():
	state_machine.enter_state("Move")
