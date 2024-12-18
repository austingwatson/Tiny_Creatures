extends Node

const juice = preload("res://resources/juice/juice.tres")

export var camera_speed = 0

var level_scene
var level = null
var camera_limit_hor = Vector2.ZERO
var camera_limit_vert = Vector2.ZERO

onready var entity_manager = $EntityManager
onready var dropper = $Dropper
onready var player_controls = $PlayerControls
onready var hud = $HUD
onready var camera = $Camera2D
	

func _ready():
	Engine.time_scale = 1
	level = level_scene.instance()
	player_controls.level = level
	add_child(level)
	level.connect("task_done", self, "_on_task_done")
	level.connect("task_failed", self, "_on_task_failed")
	level.connect("reset", self, "_on_level_reset")
	hud.drop_creature()
	dropper.switch_creature(-1)
	
	var foreground_size = level.get_node("Foreground").texture.get_size()
	camera_limit_hor = Vector2(-foreground_size.x / 4, foreground_size.x / 4)
	camera_limit_vert = Vector2(-foreground_size.y / 4, foreground_size.y / 4)
	#camera.limit_left = -foreground_size.x / 2
	#camera.limit_right = foreground_size.x / 2
	#camera.limit_bottom = foreground_size.y / 2
	#camera.limit_top = -foreground_size.y / 2

	$TestPetriDish.visible = false
	$Music.play()
	

func _input(event):
	if event.is_action_released("speed1"):
		hud.set_speed_setting(1)
	elif event.is_action_released("speed2"):
		hud.set_speed_setting(2)
	elif event.is_action_released("speed3"):
		hud.set_speed_setting(3)
	
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
	elif event.is_action_released("speed_doom"):
		Engine.time_scale = 20
	elif not $Camera2D.current and event.is_action_pressed("follow"):
		$Camera2D.current = true
	elif event.is_action_released("test_fail"):
		level.any_task_failed()
		
	
func _process(delta):
	var camera_direction = Input.get_vector("camera_left", "camera_right", "camera_up", "camera_down")
	camera.position += camera_direction * camera_speed * delta
	
	if camera.position.x <= camera_limit_hor.x:
		camera.position.x = camera_limit_hor.x
	elif camera.position.x >= camera_limit_hor.y:
		camera.position.x = camera_limit_hor.y
	
	if camera.position.y <= camera_limit_vert.x:
		camera.position.y = camera_limit_vert.x
	elif camera.position.y >= camera_limit_vert.y:
		camera.position.y = camera_limit_vert.y


func _on_PlayerControls_selected_creature(creature):
	dropper.switch_creature(creature)


func _on_PlayerControls_drop_creature():
	dropper.drop_creature()


func _on_Dropper_dropper_done(spawn_position):
	player_controls.drop_creature(spawn_position)
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
	

func _on_task_done():
	if not is_instance_valid(self):
		return
	if not is_inside_tree():
		return
	var main = get_parent()
	Success.victory = true
	main.change_scene(main.Scene.LEVEL_SELECT)


func _on_task_failed():
	var main = get_parent()
	main.change_scene(main.Scene.TITLE_SCREEN)


func _on_HUD_scary_boy_selected():
	player_controls.change_creature(juice.Creature.SCARY_BOY)


func _on_HUD_reset():
	level.reset_level()
	

func _on_level_reset():
	var main = get_parent()
	main.change_scene(main.Scene.GAME_SCREEN, level_scene, $Camera2D.position, dropper.global_position)


func _on_HUD_level_select():
	var main = get_parent()
	main.change_scene(main.Scene.LEVEL_SELECT)
