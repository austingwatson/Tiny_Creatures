extends Node

signal selected_creature(creature)
signal drop_creature()

const juice = preload("res://resources/juice/juice.tres")

export(NodePath) onready var entity_manager = get_node(entity_manager) as Node2D
export(NodePath) onready var camera = get_node(camera) as Camera2D

var level
var current_creature = juice.Creature.SLUG
var dropper_animating = false

var dragging_camera = false
var mouse_start_position = Vector2.ZERO
var screen_start_position = Vector2.ZERO


func _input(event):
	if event.is_action_pressed("drag_camera"):
		mouse_start_position = event.position
		screen_start_position = camera.position
		dragging_camera = true
	elif event.is_action_released("drag_camera"):
		dragging_camera = false
	elif event is InputEventMouseMotion and dragging_camera:
		camera.position = mouse_start_position - event.position + screen_start_position


func _unhandled_input(event):
	if event.is_action_released("drop_entity") and not dropper_animating and juice.has_juice(current_creature):
		dropper_animating = true
		emit_signal("drop_creature")
				
	elif event.is_action_released("next_creature") and not dropper_animating:		
		current_creature += 1
		if current_creature >= juice.Creature.size():
			current_creature = 0
		emit_signal("selected_creature", current_creature)
	elif event.is_action_released("prev_creature") and not dropper_animating:
		current_creature -= 1
		if current_creature < 0:
			current_creature = juice.Creature.size() - 1
		emit_signal("selected_creature", current_creature)
		

func change_creature(creature):
	current_creature = creature
	emit_signal("selected_creature", current_creature)

		
func drop_creature(spawn_position):
	juice.use_juice(current_creature)
	match current_creature:
		juice.Creature.SLUG:
			entity_manager.add_entity(PackedScenes.slug_scene.instance(), spawn_position, level)
		juice.Creature.SLIME:
			entity_manager.add_entity(PackedScenes.slime_scene.instance(), spawn_position, level)
		juice.Creature.AMOEBA:
			entity_manager.add_entity(PackedScenes.amoeba_scene.instance(), spawn_position, level)
		juice.Creature.SCARY_BOY:
			entity_manager.add_entity(PackedScenes.scary_boy_scene.instance(), spawn_position, level)
	dropper_animating = false
