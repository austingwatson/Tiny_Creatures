extends Node

enum Scene {
	TITLE_SCREEN,
	GAME_SCREEN,
}

var title_screen = preload("res://scenes/title_screen.tscn").instance()
var game_screen = preload("res://scenes/game_screen.tscn").instance()


func _ready():
	add_child(title_screen)
	

func change_scene(name):
	remove_child(get_child(0))
	match name:
		Scene.TITLE_SCREEN:
			add_child(title_screen)
		Scene.GAME_SCREEN:
			add_child(game_screen)
			game_screen.reset()
