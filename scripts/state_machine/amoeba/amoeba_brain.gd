extends "res://scripts/state_machine/state_machine.gd"

export(NodePath) onready var amoeba = get_node(amoeba) as Area2D
export(NodePath) onready var movement = get_node(movement) as Node
export(NodePath) onready var detection = get_node(detection) as Area2D


func _ready():
	var idle = $Idle
	detection.connect("area_entered", idle, "_on_area_entered")
	
	var move_to = $MoveTo
	move_to.amoeba = amoeba
	move_to.movement = movement
