extends "res://scripts/state_machine/state.gd"

const slime_states = preload("res://resources/slime/slime.tres")

onready var timer = $Timer


func enter(_data):
	timer.start(rand_range(slime_states.idle_time.x, slime_states.idle_time.y))


func _on_Timer_timeout():
	state_machine.enter_state("Move")
