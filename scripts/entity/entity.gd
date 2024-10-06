extends KinematicBody2D

enum Creature {
	NONE,
	SLUG,
	SLIME,
	AMOEBA,
}

export(Creature) var creature = Creature.NONE

var entity_manager
var level


func _ready():
	if has_node("Trail"):
		$Trail.level = level
