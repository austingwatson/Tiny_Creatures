extends "res://scripts/state_machine/state.gd"

const amoeba_stats = preload("res://resources/amoeba_stats/amoeba_stats.tres")

var amoeba
var movement
var animated_sprite: AnimatedSprite
var chomp
var target = Vector2.ZERO
var hit_target = false

func enter(data):
	hit_target = false

	animated_sprite.play("crouch")
	var direction = amoeba.global_position.direction_to(target)
	if direction.x >= 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	yield(animated_sprite, "animation_finished")
	
	if not chomp.is_connected("body_entered", self, "_on_body_entered"):
		chomp.connect("body_entered", self, "_on_body_entered")
	var slime = data["slime"]
	if not is_instance_valid(slime):
		state_machine.enter_state("LungeCooldown")
		return
	target = slime.global_position
	movement.direction = amoeba.global_position.direction_to(target)
	if movement.direction.x >= 0:
		animated_sprite.flip_h = false
	else:
		animated_sprite.flip_h = true
	movement.speed = amoeba_stats.lunge_speed
	animated_sprite.play("lunge")
	yield(animated_sprite, "animation_finished")
	if not hit_target:
		state_machine.enter_state("LungeCooldown")
	

func leave():
	if chomp.is_connected("body_entered", self, "_on_body_entered"):
		chomp.disconnect("body_entered", self, "_on_body_entered")
	movement.direction = Vector2.ZERO
	

func update(_delta):
	movement.move_kinematic_body(amoeba)
	

func _on_body_entered(body):
	if body.creature != Juice.Creature.SLIME:
		return
	body.queue_free()
	hit_target = true
	chomp.hit()
	state_machine.enter_state("Reproduce")
