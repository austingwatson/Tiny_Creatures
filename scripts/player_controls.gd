extends Node

enum Creature {
	SLUG,
	SLIME,
	AMOEBA,
}

signal selected_creature(creature)

export(NodePath) onready var entity_manager = get_node(entity_manager) as Node2D
export(NodePath) onready var camera = get_node(camera) as Camera2D

var level
var current_creature = Creature.SLUG

var dragging_camera = false
var mouse_start_position = Vector2.ZERO
var screen_start_position = Vector2.ZERO


func _unhandled_input(event):
	if event.is_action_released("drop_entity"):
		match current_creature:
			Creature.SLUG:
				entity_manager.add_entity_at_mouse(PackedScenes.slug_scene.instance(), level)
			Creature.SLIME:
				entity_manager.add_entity_at_mouse(PackedScenes.slime_scene.instance(), level)
			Creature.AMOEBA:
				entity_manager.add_entity_at_mouse(PackedScenes.amoeba_scene.instance(), level)
				
	elif event.is_action_released("next_creature"):
		current_creature += 1
		if current_creature >= Creature.size():
			current_creature = 0
		emit_signal("selected_creature", current_creature)
	elif event.is_action_released("prev_creature"):
		current_creature -= 1
		if current_creature < 0:
			current_creature = Creature.size() - 1
		emit_signal("selected_creature", current_creature)
			
	elif event.is_action_pressed("drag_camera"):
		mouse_start_position = event.position
		screen_start_position = camera.position
		dragging_camera = true
	elif event.is_action_released("drag_camera"):
		dragging_camera = false
	elif event is InputEventMouseMotion and dragging_camera:
		camera.position = mouse_start_position - event.position + screen_start_position
