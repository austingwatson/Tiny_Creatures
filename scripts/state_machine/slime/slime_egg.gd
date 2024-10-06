extends "res://scripts/state_machine/state.gd"

const slime_stats = preload("res://resources/slime_stats/slime_stats.tres")

var slime
var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("egg")
	timer.start(rand_range(slime_stats.egg_time.x, slime_stats.egg_time.y))


func leave():
	slime.level.set_tile(slime.global_position, Tile.SLIME)
	SoundPlayer.play_hatch_sound()


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
