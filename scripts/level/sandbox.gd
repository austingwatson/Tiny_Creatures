extends "res://scripts/level/level.gd"

const juice = preload("res://resources/juice/juice.tres")


func _ready():
	juice.init_juice(99, 99, 99, 99)
