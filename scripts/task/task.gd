class_name Task
extends Node

signal progress_made
signal task_done
signal task_failed

export var task_name = ""
export var task_description = ""
export var current = 0
export var needed = 0
export(Texture) var task_progress_texture

var sent_task_done = false

onready var amount = $VBoxContainer/Amount
onready var task_progress = $TaskProgress


func _ready():
	$VBoxContainer/Name.text = task_name
	$VBoxContainer/Description.text = task_description
	amount.text = str(current) + "/" + str(needed)
	
	task_progress.texture_progress = task_progress_texture
	task_progress.max_value = needed
	task_progress.value = current
	

func add_current(amount):
	current += amount
	self.amount.text = str(current) + "/" + str(needed)
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
	if current > needed:
		current = needed
		return
	self.amount.text = str(current) + "/" + str(needed)
	if current >= needed:
		emit_signal("task_done")
	else:
		emit_signal("progress_made")


func fail_task():
	emit_signal("task_failed")
