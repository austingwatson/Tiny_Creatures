extends "res://scripts/state_machine/state.gd"

const slug_states = preload("res://resources/slug/slug.tres")

var slug
var movement

onready var timer = $Timer


func enter(_data):
	var rng = randi() % 4
	match rng:
		0:
			movement.direction = Vector2.UP
		1:
			movement.direction = Vector2.LEFT
		2:
			movement.direction = Vector2.DOWN
		3:
			movement.direction = Vector2.RIGHT
	timer.start(rand_range(slug_states.move_time.x, slug_states.move_time.y))


func leave():
	movement.direction = Vector2.ZERO
	

func update(delta):
	slug.global_position = movement.move(slug.global_position, delta)


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
