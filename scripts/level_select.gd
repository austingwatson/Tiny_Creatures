class_name LevelSelect
extends Control

const slug_level = preload("res://scenes/level/slug_trail_level.tscn")
const slime_level = preload("res://scenes/level/slime_level.tscn")
const amoeba_level = preload("res://scenes/level/amoeba_level.tscn")
const scary_level = preload("res://scenes/level/scary_level.tscn")


func _input(event):
	if not OS.is_debug_build():
		return
		
	if event.is_action_pressed("exit_game"):
		get_tree().quit()


func _on_SlugLevel_pressed():
	var main = get_parent()
	main.change_scene(main.Scene.GAME_SCREEN, slug_level)


func _on_SlimeLevel_pressed():
	var main = get_parent()
	main.change_scene(main.Scene.GAME_SCREEN, slime_level)
