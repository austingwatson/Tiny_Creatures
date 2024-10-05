extends "res://scripts/state_machine/state_machine.gd"

export(NodePath) onready var slime = get_node(slime) as Area2D
export(NodePath) onready var movement = get_node(movement) as Node
export(NodePath) onready var reproduce = get_node(reproduce) as Node2D


func _ready():
	var move = $Move
	move.slime = slime
	move.movement = movement
	
	var reproduce = $Reproduce
	reproduce.slime = slime
	reproduce.reproduce = self.reproduce
	
	init()
