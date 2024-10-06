extends "res://scripts/state_machine/state.gd"

const amoeba_stats = preload("res://resources/amoeba_stats/amoeba_stats.tres")

var detection
var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	detection.connect("body_entered", self, "_on_body_entered")
	detection.enable()
	animated_sprite.play("idle")
	timer.start(amoeba_stats.get_random_idle_time())
	

func leave():
	detection.disconnect("body_entered", self, "_on_body_entered")
	detection.disable()
	timer.stop()


func _on_body_entered(body):
	if body.creature == Juice.Creature.SLIME:
		state_machine.enter_state("Chase", {"slime": body})


func _on_Timer_timeout():
	state_machine.enter_state("Wander")
