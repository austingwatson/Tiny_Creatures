extends Area2D

export var scare_range = 0
export var scare_slug = false
export var scare_slime = false
export var scare_amoeba = false
export var scare_scary_boy = false

var creatures_to_scare = []

onready var collision_shape = $CollisionShape2D


func _ready():
	collision_shape.shape.radius = scare_range
	
	if scare_slug:
		creatures_to_scare.append(Juice.Creature.SLUG)
	if scare_slime:
		creatures_to_scare.append(Juice.Creature.SLIME)
	if scare_amoeba:
		creatures_to_scare.append(Juice.Creature.AMOEBA)
	if scare_scary_boy:
		creatures_to_scare.append(Juice.Creature.SCARY_BOY)


func enable():
	collision_shape.set_deferred("disabled", false)
	

func disable():
	collision_shape.set_deferred("disabled", true)


func _on_Scare_body_entered(body):
	if creatures_to_scare.has(body.creature):
		match body.creature:
			Juice.Creature.SLUG:
				body.get_node("SlugBrain").force_state_change("Flee", ["Egg"], {"scare": get_parent()})
