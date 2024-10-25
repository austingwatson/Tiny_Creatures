class_name Task
extends Node

signal progress_made
signal task_done
signal task_failed

export var task_description = ""
export var current = 0
export var needed = 0
export(Texture) var task_progress_texture

var sent_task_done = false

onready var task_progress = $TaskProgress
onready var description = $Description


func _ready():
	task_progress.texture_progress = task_progress_texture
	task_progress.max_value = needed
	task_progress.value = current
	description.text = task_description
	

func add_current(amount):
	current += amount
	if current >= needed:
		current = needed
		if not sent_task_done:
			emit_signal("task_done")
			sent_task_done = true
	else:
		emit_signal("progress_made")
	task_progress.value = current


func set_current(amount):
	current = amount
	if current >= needed:
		current = needed
		if not sent_task_done:
			emit_signal("task_done")
			sent_task_done = true
	else:
		emit_signal("progress_made")
	task_progress.value = current


func fail_task():
	emit_signal("task_failed")


func _on_Background_mouse_entered():
	description.visible = true


func _on_Background_mouse_exited():
	description.visible = false
