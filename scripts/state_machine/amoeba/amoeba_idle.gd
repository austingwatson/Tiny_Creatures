extends "res://scripts/state_machine/state.gd"

var detection
var animated_sprite: AnimatedSprite


func enter(_data):
	detection.connect("body_entered", self, "_on_body_entered")
	animated_sprite.play("idle")
	

func leave():
	detection.disconnect("body_entered", self, "_on_body_entered")


func _on_body_entered(body):
	state_machine.enter_state("Chase", {"slime": body})
