class_name Task
extends Node

signal progress_made
signal task_done
signal task_failed

export var task_name = ""
export var task_description = ""
export var current = 0
export var needed = 0

onready var amount = $VBoxContainer/Amount


func _ready():
	$VBoxContainer/Name.text = task_name
	$VBoxContainer/Description.text = task_description
	amount.text = str(current) + "/" + str(needed)
	

func add_current(amount):
	current += amount
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
