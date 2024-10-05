extends Node

enum Creature {
	SLUG,
	SLIME,
}

export(NodePath) onready var entity_manager = get_node(entity_manager) as Node2D
export(NodePath) onready var level = get_node(level) as TileMap

var current_creature = Creature.SLUG


func _unhandled_input(event):
	if event.is_action_released("drop_entity"):
		match current_creature:
			Creature.SLUG:
				entity_manager.add_entity_at_mouse(EntityScenes.slug_scene.instance(), level)
			Creature.SLIME:
				entity_manager.add_entity_at_mouse(EntityScenes.slime_scene.instance(), level)
				
	elif event.is_action_released("next_creature"):
		current_creature += 1
		if current_creature >= Creature.size():
			current_creature = 0
	elif event.is_action_released("prev_creature"):
		current_creature -= 1
		if current_creature < 0:
			current_creature = Creature.size() - 1
