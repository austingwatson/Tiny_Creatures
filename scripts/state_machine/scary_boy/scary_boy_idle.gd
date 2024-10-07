extends "res://scripts/state_machine/state.gd"

const scary_boy_stats = preload("res://resources/scary_boy_stats/scary_boy_stats.tres")

var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	timer.start(scary_boy_stats.get_random_idle_time())
	animated_sprite.play("idle")
	

func leave():
	timer.stop()


func _on_Timer_timeout():
	state_machine.enter_state("Scare")
