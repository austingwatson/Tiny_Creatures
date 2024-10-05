extends Area2D

var entity_manager
var level


func _ready():
	if has_node("Trail"):
		$Trail.level = level
