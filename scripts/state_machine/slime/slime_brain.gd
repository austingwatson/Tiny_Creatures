extends "res://scripts/state_machine/state_machine.gd"

export(NodePath) onready var slime = get_node(slime) as KinematicBody2D
export(NodePath) onready var movement = get_node(movement) as Node
export(NodePath) onready var reproduce = get_node(reproduce) as Node2D
export(NodePath) onready var animated_sprite = get_node(animated_sprite) as AnimatedSprite


func _ready():
	var egg = $Egg
	egg.animated_sprite = animated_sprite
	egg.slime = slime
	
	var idle = $Idle
	idle.animated_sprite = animated_sprite
	
	var move = $Move
	move.slime = slime
	move.movement = movement
	move.animated_sprite = animated_sprite
	
	var reproduce = $Reproduce
	reproduce.slime = slime
	reproduce.reproduce = self.reproduce
	reproduce.animated_sprite = animated_sprite
	
	init()
