extends Node2D


func _process(_delta):
	#print(get_child_count())
	pass


func add_entity(entity, global_position, level):
	entity.entity_manager = self
	entity.level = level
	entity.global_position = global_position
	add_child(entity)


func add_entity_at_mouse(entity, level):
	add_entity(entity, get_global_mouse_position(), level)
