extends Node2D

enum Entity {
	SLUG,
	SLIME,
	AMOEBA,
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
		Entity.AMOEBA:
			entity_scene = PackedScenes.amoeba_scene


func reproduce():
	var x = rand_range(-4, 4)
	var y = rand_range(-4, 4)
	entity_manager.add_entity(entity_scene.instance(), get_parent().global_position + Vector2(x, y), level)
