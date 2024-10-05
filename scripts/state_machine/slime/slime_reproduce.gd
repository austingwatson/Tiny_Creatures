extends "res://scripts/state_machine/state.gd"

const slime_states = preload("res://resources/slime/slime.tres")

var slime
var reproduce

onready var timer = $Timer


func enter(_data):
	timer.start(rand_range(slime_states.reproduce_time.x, slime_states.reproduce_time.y))


func leave():
	reproduce.reproduce()
	slime.level.set_tile(slime.global_position, 0)


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
