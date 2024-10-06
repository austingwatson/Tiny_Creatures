extends Node


func _ready():
	Engine.time_scale = 1


func _on_Play_pressed():
	var main = get_parent()
	main.change_scene(main.Scene.GAME_SCREEN)
