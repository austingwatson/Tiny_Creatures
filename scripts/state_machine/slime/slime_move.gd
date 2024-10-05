extends "res://scripts/state_machine/state.gd"

const slime_states = preload("res://resources/slime/slime.tres")

var slime
var movement

onready var timer = $Timer


func enter(_data):
	movement.direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	timer.start(rand_range(slime_states.move_time.x, slime_states.move_time.y))
	

func leave():
	movement.direction = Vector2.ZERO
	

func update(delta):
	slime.global_position = movement.move(slime.global_position, delta)
	if(slime.level.get_tile(slime.global_position) == 1):
		state_machine.enter_state("Reproduce")


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
