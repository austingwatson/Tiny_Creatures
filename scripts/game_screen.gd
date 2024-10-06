extends Node

const juice = preload("res://resources/juice/juice.tres")

onready var dropper = $Dropper
onready var player_controls = $PlayerControls
onready var hud = $HUD


func _ready():
	juice.init_juice(3, 5, 1)
	hud.drop_creature()
	dropper.switch_creature(player_controls.current_creature)
	
	var level = preload("res://scenes/level/level.tscn").instance()
	player_controls.level = level
	add_child(level)
	
	var foreground_size = level.get_node("Foreground").texture.get_size()
	var camera = $Camera2D
	camera.limit_left = -foreground_size.x / 2
	camera.limit_right = foreground_size.x / 2
	camera.limit_bottom = foreground_size.y / 2
	camera.limit_top = -foreground_size.y / 2

	$TestPetriDish.visible = false
	

func _input(event):
	if not OS.is_debug_build():
		return
	
	if event.is_action_pressed("exit_game"):
		get_tree().quit()
	elif event.is_action_released("toggle_fullscreen"):
		OS.window_fullscreen = not OS.window_fullscreen
		if not OS.window_fullscreen:
			var window_size = Vector2(1280, 720)
			var screen_size = OS.get_screen_size()
			OS.window_size = window_size
			var centered = Vector2(screen_size.x / 2 - window_size.x / 2, screen_size.y / 2 - window_size.y / 2)
			OS.window_position = centered
	elif event.is_action_released("test_petri"):
		$TestPetriDish.tiles = $Level.get_petri_dish($EntityManager.get_children())
		$TestPetriDish.redraw()
		$TestPetriDish.visible = not $TestPetriDish.visible
	elif event.is_action_released("speed1"):
		Engine.time_scale = 1
	elif event.is_action_released("speed2"):
		Engine.time_scale = 2
	elif event.is_action_released("speed3"):
		Engine.time_scale = 3


func _on_PlayerControls_selected_creature(creature):
	dropper.switch_creature(creature)


func _on_PlayerControls_drop_creature():
	dropper.drop_creature()


func _on_Dropper_dropper_done():
	player_controls.drop_creature()
	hud.drop_creature()


func _on_Timer_timeout():
	#juice.print_juice()
	pass


func _on_HUD_slug_selected():
	player_controls.change_creature(juice.Creature.SLUG)


func _on_HUD_slime_selected():
	player_controls.change_creature(juice.Creature.SLIME)


func _on_HUD_amoeba_selected():
	player_controls.change_creature(juice.Creature.AMOEBA)
