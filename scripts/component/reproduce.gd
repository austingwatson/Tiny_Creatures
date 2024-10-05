extends Node2D

enum Entity {
	SLUG,
	SLIME,
}

export(Entity) var entity

var entity_scene
onready var entity_manager = get_parent().entity_manager
onready var level = get_parent().level


func _ready():
	match entity:
		Entity.SLUG:
			entity_scene = PackedScenes.slug_scene
		Entity.SLIME:
			entity_scene = PackedScenes.slime_scene


func reproduce():
	entity_manager.add_entity(entity_scene.instance(), get_parent().global_position + Vector2(0, 16), level)
