extends "res://scripts/state_machine/state.gd"

var amoeba
var movement
var slime
var animated_sprite: AnimatedSprite
var lunge


func enter(data):
	slime = data["slime"]
	animated_sprite.play("move")
	lunge.connect("body_entered", self, "_on_body_entered")
	

func leave():
	movement.direction = Vector2.ZERO
	lunge.disconnect("body_entered", self, "_on_body_entered")


func update(_delta):
	if not is_instance_valid(slime):
		state_machine.enter_state("Idle")
		return
	
	movement.direction = amoeba.global_position.direction_to(slime.global_position)
	movement.move_kinematic_body(amoeba)

	if movement.direction.x >= 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true


func _on_body_entered(body):
	state_machine.enter_state("Lunge", {"slime": body})