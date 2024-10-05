extends "res://scripts/state_machine/state.gd"

var amoeba
var movement
var slime


func enter(data):
	slime = data["slime"]
	

func update(delta):
	movement.direction = amoeba.global_position.direction_to(slime.global_position)
	amoeba.global_position = movement.move(amoeba.global_position, delta)
