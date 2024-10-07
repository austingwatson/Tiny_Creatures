extends "res://scripts/state_machine/state.gd"

const scary_boy_stats = preload("res://resources/scary_boy_stats/scary_boy_stats.tres")

var animated_sprite: AnimatedSprite
var scare

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("scare")
	timer.start(scary_boy_stats.get_random_scare_time())
	scare.enable()
	

func leave():
	timer.stop()
	scare.disable()


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
