extends "res://scripts/state_machine/state.gd"

const slime_stats = preload("res://resources/slime_stats/slime_stats.tres")

var slime
var movement
var animated_sprite: AnimatedSprite
var hunger

onready var timer = $Timer


func enter(_data):
	movement.speed = slime_stats.base_speed
	movement.direction = Vector2(rand_range(-1, 1), rand_range(-1, 1))
	timer.start(rand_range(slime_stats.move_time.x, slime_stats.move_time.y))
	
	animated_sprite.play("move")
	if movement.direction.x >= 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	

func leave():
	movement.direction = Vector2.ZERO
	timer.stop()
	

func update(_delta):
	movement.move_kinematic_body(slime)
	if(slime.level.get_tile(slime.global_position) == Tile.SLUG_TRAIL):
		hunger.reset_hunger()
		timer.stop()
		state_machine.enter_state("Reproduce")


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
