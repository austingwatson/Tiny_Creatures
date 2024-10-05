extends "res://scripts/state_machine/state_machine.gd"

export(NodePath) onready var slug = get_node(slug) as Node2D
export(NodePath) onready var movement = get_node(movement) as Node


func _ready():
	var move = $Move
	move.slug = slug
	move.movement = movement
	init()
