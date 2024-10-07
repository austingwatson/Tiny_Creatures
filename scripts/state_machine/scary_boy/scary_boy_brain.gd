extends "res://scripts/state_machine/state_machine.gd"

export(NodePath) onready var scary_boy = get_node(scary_boy) as KinematicBody2D
export(NodePath) onready var animated_sprite = get_node(animated_sprite) as AnimatedSprite
export(NodePath) onready var scare = get_node(scare) as Area2D


func _ready():
	var egg = $Egg
	egg.scary_boy = scary_boy
	egg.animated_sprite = animated_sprite
	
	var idle = $Idle
	idle.animated_sprite = animated_sprite
	
	var scare = $Scare
	scare.animated_sprite = animated_sprite
	scare.scare = self.scare
	
	init()
