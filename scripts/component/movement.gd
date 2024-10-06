extends Node

var speed = 0
var direction = Vector2.ZERO
	

func move_kinematic_body(body):
	body.move_and_slide(direction.normalized() * speed)	
	

func move_global_position(global_position, delta):
	global_position += direction.normalized() * speed * delta
	return global_position
