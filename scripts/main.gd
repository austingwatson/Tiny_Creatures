extends Node

enum Scene {
	TITLE_SCREEN,
	LEVEL_SELECT,
	GAME_SCREEN,
}

const title_screen = preload("res://scenes/title_screen.tscn")
const level_select = preload("res://scenes/level_select.tscn")
const game_screen = preload("res://scenes/game_screen.tscn")


func _ready():
	add_child(title_screen.instance())
	

func change_scene(name, level_scene = null, camera_position = Vector2.ZERO, dropper_position = Vector2.ZERO):
	remove_child(get_child(0))
	match name:
		Scene.TITLE_SCREEN:
			add_child(title_screen.instance())
		Scene.LEVEL_SELECT:
			add_child(level_select.instance())
		Scene.GAME_SCREEN:
			var game_screen_scene = game_screen.instance()
			game_screen_scene.level_scene = level_scene
			add_child(game_screen_scene)
			if camera_position != Vector2.ZERO:
				game_screen_scene.get_node("Camera2D").position = camera_position
			if dropper_position != Vector2.ZERO:
				game_screen_scene.get_node("Dropper").global_position = dropper_position
