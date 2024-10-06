extends "res://scripts/state_machine/state.gd"

const slug_stats = preload("res://resources/slug_stats/slug_stats.tres")

var slug
var movement
var animated_sprite: AnimatedSprite
var trail

onready var timer = $Timer


func enter(_data):
	movement.speed = slug_stats.base_speed
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
	timer.start(slug_stats.get_random_move_time())
	
	animated_sprite.play("move")
	if movement.direction.x >= 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
		
	trail.can_make_trail = true


func leave():
	movement.direction = Vector2.ZERO
	trail.can_make_trail = false
	timer.stop()
	

func update(_delta):
	movement.move_kinematic_body(slug)
	smart_about_walls()
	

func smart_about_walls():
	var collision_count = slug.get_slide_count()
	if collision_count > 0:
		state_machine.enter_state("Idle")


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
