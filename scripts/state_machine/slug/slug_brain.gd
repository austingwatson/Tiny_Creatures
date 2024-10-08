extends "res://scripts/state_machine/state_machine.gd"

export(NodePath) onready var slug = get_node(slug) as KinematicBody2D
export(NodePath) onready var movement = get_node(movement) as Node
export(NodePath) onready var animated_sprite = get_node(animated_sprite) as AnimatedSprite
export(NodePath) onready var trail = get_node(trail) as Node2D
export(NodePath) onready var hurt = get_node(hurt) as Node2D


func _ready():
	var egg = $Egg
	egg.animated_sprite = animated_sprite
	
	var idle = $Idle
	idle.animated_sprite = animated_sprite
	
	var move = $Move
	move.slug = slug
	move.movement = movement
	move.animated_sprite = animated_sprite
	move.trail = trail
	
	var flee = $Flee
	flee.slug = slug
	flee.animated_sprite = animated_sprite
	flee.movement = movement
	
	var dead = $Dead
	dead.slug = slug
	dead.animated_sprite = animated_sprite
	
	hurt.connect("dead", self, "_on_dead")
	
	init()


func _on_dead():
	enter_state("Dead")
