extends "res://scripts/state_machine/state.gd"

const amoeba_stats = preload("res://resources/amoeba_stats/amoeba_stats.tres")

var amoeba
var movement
var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	movement.speed = amoeba_stats.base_speed
	movement.direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	timer.start(amoeba_stats.get_random_wander_time())
	
	animated_sprite.play("move")
	if movement.direction.x >= 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true


func leave():
	movement.direction = Vector2.ZERO
	timer.stop()


func update(_delta):
	movement.move_kinematic_body(amoeba)


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
