extends Node

var playing_music = false


func _ready():
	Engine.time_scale = 1
	

func _input(event):
	if not playing_music and (event is InputEventKey or event is InputEventMouseButton):
		$Music.play()
		playing_music = true
	
	if not OS.is_debug_build():
		return
		
	if event.is_action_pressed("exit_game"):
		get_tree().quit()


func _on_Play_pressed():
	var main = get_parent()
	main.change_scene(main.Scene.LEVEL_SELECT)
