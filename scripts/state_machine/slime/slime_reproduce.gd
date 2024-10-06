extends "res://scripts/state_machine/state.gd"

const slime_stats = preload("res://resources/slime_stats/slime_stats.tres")

var slime
var reproduce
var animated_sprite: AnimatedSprite
var movement

onready var eat_timer = $EatTimer
onready var reproduce_timer = $ReproduceTimer


func enter(_data):
	movement.speed = slime_stats.reproduce_speed
	movement.direction = Vector2.ZERO
	if movement.direction.x >= 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	eat_timer.start(slime_stats.get_random_eat_time())


func leave():
	reproduce.reproduce()
	reproduce.reproduce()
	eat_timer.stop()
	reproduce_timer.stop()
	

func update(_delta):
	movement.move_kinematic_body(slime)


func _on_EatTimer_timeout():
	slime.level.set_tile(slime.global_position, Tile.NONE)
	movement.direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	animated_sprite.play("reproduce")
	reproduce_timer.start(slime_stats.get_random_reproduce_time())


func _on_ReproduceTimer_timeout():
	state_machine.enter_state("Dead")
