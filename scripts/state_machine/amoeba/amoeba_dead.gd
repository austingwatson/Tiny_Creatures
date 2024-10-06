extends "res://scripts/state_machine/state.gd"

const amoeba_stats = preload("res://resources/amoeba_stats/amoeba_stats.tres")

var amoeba
var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("dead")
	timer.start(amoeba_stats.get_random_dead_time())


func leave():
	timer.stop()


func _on_Timer_timeout():
	amoeba.queue_free()
