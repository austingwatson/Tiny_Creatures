extends "res://scripts/state_machine/state.gd"

const slug_states = preload("res://resources/slug/slug.tres")

onready var timer = $Timer


func enter(_data):
	timer.start(rand_range(slug_states.idle_time.x, slug_states.idle_time.y))


func _on_Timer_timeout():
	state_machine.enter_state("Move")
