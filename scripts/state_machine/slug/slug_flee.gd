extends "res://scripts/state_machine/state.gd"

const slug_stats = preload("res://resources/slug_stats/slug_stats.tres")

var slug
var movement
var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(data):
	movement.speed = slug_stats.flee_speed
	timer.start(slug_stats.get_random_flee_time())
	animated_sprite.play("move")
	
	var scare = data["scare"]
	movement.direction = -slug.global_position.direction_to(scare.global_position)
	if movement.direction.x >= 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true


func leave():
	movement.direction = Vector2.ZERO
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
