extends Node2D

enum Entity {
	SLUG,
	SLIME,
	AMOEBA,
}

export(Entity) var entity

const distance = Vector2(16, 16)
const min_distance = Vector2(8, 8)

var entity_scene

onready var entity_manager = get_parent().entity_manager
onready var level = get_parent().level
onready var lay_egg_sound = $LayEggSound


func _ready():
	match entity:
		Entity.SLUG:
			entity_scene = PackedScenes.slug_scene
		Entity.SLIME:
			entity_scene = PackedScenes.slime_scene
		Entity.AMOEBA:
			entity_scene = PackedScenes.amoeba_scene


func reproduce():
	entity_manager.add_entity(entity_scene.instance(), get_parent().global_position + Vector2(get_x(), get_y()), level)
	lay_egg_sound.play()


func get_x():
	var x = rand_range(-distance.x, distance.x)
	if x > -min_distance.x and x <= 0:
		x = -min_distance.x
	elif x < min_distance.x and x >= 0:
		x = min_distance.x
	return x


func get_y():
	var y = rand_range(-distance.y, distance.y)
	if y > -min_distance.y and y <= 0:
		y = -min_distance.y
	elif y < min_distance.y and y >= 0:
		y = min_distance.y
	return y
