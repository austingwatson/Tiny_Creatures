extends "res://scripts/state_machine/state.gd"

const scary_boy_stats = preload("res://resources/scary_boy_stats/scary_boy_stats.tres")

var scary_boy
var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("egg")
	timer.start(scary_boy_stats.get_random_egg_time())


func leave():
	SoundPlayer.play_hatch_sound()
	timer.stop()


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
