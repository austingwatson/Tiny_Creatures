extends KinematicBody2D

export(Juice.Creature) var creature = Juice.Creature.SLUG

var entity_manager
var level
var mouse_inside = false


func _ready():
	if has_node("Trail"):
		$Trail.level = level
	if has_node("Hurt"):
		$Hurt.level = level
		

func _input(event):
	if not OS.is_debug_build():
		return
	
	if mouse_inside:
		if event.is_action_pressed("kill"):
			queue_free()
		elif event.is_action_pressed("follow"):
			$Camera2D.set_deferred("current", true)
	

func _on_Entity_mouse_entered():
	mouse_inside = true


func _on_Entity_mouse_exited():
	mouse_inside = false
