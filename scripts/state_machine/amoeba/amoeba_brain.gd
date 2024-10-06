extends "res://scripts/state_machine/state_machine.gd"

export(NodePath) onready var amoeba = get_node(amoeba) as KinematicBody2D
export(NodePath) onready var movement = get_node(movement) as Node
export(NodePath) onready var detection = get_node(detection) as Area2D
export(NodePath) onready var animated_sprite = get_node(animated_sprite) as AnimatedSprite
export(NodePath) onready var lunge = get_node(lunge) as Area2D
export(NodePath) onready var chomp = get_node(chomp) as Area2D
export(NodePath) onready var reproduce = get_node(reproduce) as Node2D
export(NodePath) onready var hunger = get_node(hunger) as Node

const amoeba_stats = preload("res://resources/amoeba_stats/amoeba_stats.tres")


func _ready():
	hunger.max_hunger = amoeba_stats.get_random_hunger()
	hunger.reset_hunger()
	hunger.start_timer(amoeba_stats.get_random_food_time())
	
	var egg = $Egg
	egg.animated_sprite = animated_sprite
	
	var idle = $Idle
	idle.detection = detection
	idle.animated_sprite = animated_sprite
	
	var chase = $Chase
	chase.amoeba = amoeba
	chase.movement = movement
	chase.animated_sprite = animated_sprite
	chase.lunge = lunge
	
	var lunge = $Lunge
	lunge.amoeba = amoeba
	lunge.movement = movement
	lunge.animated_sprite = animated_sprite
	lunge.chomp = chomp
	
	var reproduce = $Reproduce
	reproduce.amoeba = amoeba
	reproduce.reproduce = self.reproduce
	reproduce.animated_sprite = animated_sprite
	reproduce.hunger = hunger
	
	var dead = $Dead
	dead.amoeba = amoeba
	dead.animated_sprite = animated_sprite
	
	init()


func _on_Hunger_dead():
	enter_state("Dead")
