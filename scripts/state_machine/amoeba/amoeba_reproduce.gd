extends "res://scripts/state_machine/state.gd"

const amoeba_stats = preload("res://resources/amoeba_stats/amoeba_stats.tres")

var amoeba
var reproduce
var animated_sprite: AnimatedSprite
var hunger

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("reproduce")
	timer.start(amoeba_stats.get_random_reproduce_time())
	hunger.reset_hunger()


func leave():
	reproduce.reproduce()
	#amoeba.level.set_tile(amoeba.global_position, 0)


func _on_Timer_timeout():
	state_machine.enter_state("Idle")
