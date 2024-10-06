extends "res://scripts/state_machine/state.gd"

var amoeba
var movement
var animated_sprite: AnimatedSprite
var chomp
var target = Vector2.ZERO
var hit_target = false

func enter(data):
	hit_target = false

	animated_sprite.play("crouch")
	yield(animated_sprite, "animation_finished")
	
	chomp.connect("body_entered", self, "_on_body_entered")
	var slime = data["slime"]
	if not is_instance_valid(slime):
		state_machine.enter_state("Idle")
		return
	target = slime.global_position
	movement.direction = amoeba.global_position.direction_to(target)
	movement.speed *= 2
	animated_sprite.play("lunge")
	yield(animated_sprite, "animation_finished")
	if not hit_target:
		state_machine.enter_state("Idle")
	

func leave():
	chomp.disconnect("body_entered", self, "_on_body_entered")
	movement.speed /= 2
	movement.direction = Vector2.ZERO
	

func update(_delta):
	movement.move_kinematic_body(amoeba)
	

func _on_body_entered(body):
	if body.creature != amoeba.Creature.SLIME:
		return
	body.queue_free()
	hit_target = true
	state_machine.enter_state("Reproduce")
