extends "res://scripts/level/level.gd"

const juice = preload("res://resources/juice/juice.tres")

onready var task = $Task
onready var entity_manager = get_parent().entity_manager


func _ready():
	juice.init_juice(4, 10, 0, 0)
	task.connect("task_done", self, "_on_task_done")
	

func _process(_delta):
	var amount = 0
	for entity in entity_manager.get_children():
		if entity.creature == juice.Creature.SLIME:
			amount += 1
	task.set_current(amount)
	

func _on_task_done():
	all_tasks_done()
