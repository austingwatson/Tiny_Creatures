extends "res://scripts/level/level.gd"

const juice = preload("res://resources/juice/juice.tres")

onready var task = $Task


func _ready():
	juice.init_juice(4, 0, 0, 0)
	task.connect("task_done", self, "_on_task_done")
	

func tile_changed(_old_tile: int, new_tile: int):
	if new_tile == Tile.SLUG_TRAIL:
		task.add_current(1)


func _on_task_done():
	all_tasks_done()
