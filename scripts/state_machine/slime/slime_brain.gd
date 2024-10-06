extends "res://scripts/state_machine/state_machine.gd"

export(NodePath) onready var slime = get_node(slime) as KinematicBody2D
export(NodePath) onready var movement = get_node(movement) as Node
export(NodePath) onready var reproduce = get_node(reproduce) as Node2D
export(NodePath) onready var animated_sprite = get_node(animated_sprite) as AnimatedSprite
export(NodePath) onready var hunger = get_node(hunger) as Node

const slime_stats = preload("res://resources/slime_stats/slime_stats.tres")


func _ready():
	hunger.max_hunger = slime_stats.get_random_hunger()
	hunger.reset_hunger()
	hunger.start_timer(slime_stats.get_random_food_time())
	
	var egg = $Egg
	egg.animated_sprite = animated_sprite
	egg.slime = slime
	
	var idle = $Idle
	idle.animated_sprite = animated_sprite
	
	
	var move = $Move
	move.slime = slime
	move.movement = movement
	move.animated_sprite = animated_sprite
	move.hunger = hunger
	
	var reproduce = $Reproduce
	reproduce.slime = slime
	reproduce.reproduce = self.reproduce
	reproduce.animated_sprite = animated_sprite
	reproduce.movement = movement
	
	var dead = $Dead
	dead.slime = slime
	dead.animated_sprite = animated_sprite
	
	init()


func _on_Hunger_dead():
	$Dead.leave_slime = false
	enter_state("Dead")
