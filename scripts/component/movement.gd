extends Node

export var speed = 0

var direction = Vector2.ZERO
	

func move(global_position, delta):
	global_position += direction.normalized() * speed * delta
	return global_position
