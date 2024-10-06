extends "res://scripts/state_machine/state.gd"

const slug_stats = preload("res://resources/slug_stats/slug_stats.tres")

var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("egg")
	timer.start(slug_stats.get_random_egg_time())
	

func leave():
	SoundPlayer.play_hatch_sound()


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
