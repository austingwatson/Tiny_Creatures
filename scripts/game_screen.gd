extends Node


func _ready():
	var level = preload("res://scenes/level/level.tscn").instance()
	$PlayerControls.level = level
	add_child(level)


func _on_PlayerControls_selected_creature(creature):
	print(creature)
