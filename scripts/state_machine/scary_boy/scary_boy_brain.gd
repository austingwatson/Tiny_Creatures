extends "res://scripts/state_machine/state_machine.gd"

export(NodePath) onready var scary_boy = get_node(scary_boy) as KinematicBody2D
export(NodePath) onready var animated_sprite = get_node(animated_sprite) as AnimatedSprite
export(NodePath) onready var scare = get_node(scare) as Area2D
export(NodePath) onready var hunger = get_node(hunger) as Node
export(NodePath) onready var splat = get_node(splat) as Node2D

var dead = false


func _ready():
	var egg = $Egg
	egg.scary_boy = scary_boy
	egg.animated_sprite = animated_sprite
	
	var idle = $Idle
	idle.animated_sprite = animated_sprite
	
	var scare = $Scare
	scare.animated_sprite = animated_sprite
	scare.scare = self.scare
	
	hunger.max_hunger = 60
	hunger.reset_hunger()
	hunger.start_timer(1)
	hunger.connect("dead", self, "_on_dead")
	
	var inflate = $Inflate
	inflate.animated_sprite = animated_sprite
	inflate.scary_boy = scary_boy
	
	var dead = $Dead
	dead.animated_sprite = animated_sprite
	dead.scary_boy = scary_boy
	dead.splat = splat
	
	init()


func _on_dead():
	if dead:
		return
	dead = true
	enter_state("Inflate")
