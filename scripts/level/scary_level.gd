extends "res://scripts/level/level.gd"

const juice = preload("res://resources/juice/juice.tres")

var goal1 = false
var goal2 = false


func _ready():
	juice.init_juice(0, 10, 1, 15)
	
	var entity_manager = get_parent().entity_manager
	var slug1 = PackedScenes.slug_scene.instance()
	slug1.global_position -= Vector2(48, 0)
	slug1.entity_manager = entity_manager
	slug1.level = self
	entity_manager.add_child(slug1)
	var slug2 = PackedScenes.slug_scene.instance()
	slug2.global_position += Vector2(48, 0)
	slug2.entity_manager = entity_manager
	slug2.level = self
	entity_manager.add_child(slug2)
	

func _process(_delta):
	if goal1 and goal2:
		all_tasks_done()


func _on_Goal1_body_entered(body):
	if body.creature == juice.Creature.SLUG:
		goal1 = true


func _on_Goal1_body_exited(body):
	if body.creature == juice.Creature.SLUG:
		goal1 = false


func _on_Goal2_body_entered(body):
	if body.creature == juice.Creature.SLUG:
		goal2 = true


func _on_Goal2_body_exited(body):
	if body.creature == juice.Creature.SLUG:
		goal2 = true
