class_name LevelSelect
extends Control

enum CurrentLevel {
	SLUG_LEVEL,
	SLIME_LEVEL,
	AMOEBA_LEVEL,
	SCARY_LEVEL,
	SANDBOX,
}

const slug_level = preload("res://scenes/level/slug_trail_level.tscn")
const slime_level = preload("res://scenes/level/slime_level.tscn")
const amoeba_level = preload("res://scenes/level/amoeba_level.tscn")
const scary_level = preload("res://scenes/level/scary_level.tscn")
const sandbox_level = preload("res://scenes/level/sandbox.tscn")

var current_level = CurrentLevel.SLUG_LEVEL
var max_levels = 5
var animation_playing = false
var mouse_in = false
var show_victory = false

var names = ["Purple Trial", "Green Trial", "Red Trial", "Yellow Trial", "Sandbox"]
var descriptions = ["Spread purple goo!", "Multiply green drooplets!", "Multiply red drooplets!", "Scare purple drooplets toward sides!", "Experiment with many drooplets!"]

onready var petri_dish = $LevelSelect/PetriDish
onready var petri_dish_animation_player = $LevelSelect/PetriDish.get_node("AnimationPlayer")
onready var task_name = $TaskBG/TaskName
onready var task_description = $DesBackground/TaskDescription


func _ready():
	$AnimationPlayer.play("bob_person")
	task_name.text = names[current_level]
	task_description.text = descriptions[current_level]
	$Bubble.visible = Success.victory
	Success.victory = false


func _input(event):
	if not animation_playing and mouse_in and event.is_action_pressed("drop_entity"):
		match current_level:
			CurrentLevel.SLUG_LEVEL:
				var main = get_parent()
				main.change_scene(main.Scene.GAME_SCREEN, slug_level)
			CurrentLevel.SLIME_LEVEL:
				var main = get_parent()
				main.change_scene(main.Scene.GAME_SCREEN, slime_level)
			CurrentLevel.AMOEBA_LEVEL:
				var main = get_parent()
				main.change_scene(main.Scene.GAME_SCREEN, amoeba_level)
			CurrentLevel.SCARY_LEVEL:
				var main = get_parent()
				main.change_scene(main.Scene.GAME_SCREEN, scary_level)
			CurrentLevel.SANDBOX:
				var main = get_parent()
				main.change_scene(main.Scene.GAME_SCREEN, sandbox_level)
		
	
	if not OS.is_debug_build():
		return
		
	if event.is_action_pressed("exit_game"):
		get_tree().quit()


func _on_SelectArea_mouse_entered():
	mouse_in = true
	if animation_playing:
		return
	petri_dish_animation_player.play("open")


func _on_SelectArea_mouse_exited():
	mouse_in = false
	if animation_playing:
		return
	petri_dish_animation_player.play("RESET")


func _on_LeftArrow_pressed():
	if animation_playing:
		return
	if current_level == 0:
		return
	
	animation_playing = true
	petri_dish_animation_player.play("slide_center_left")
	yield(petri_dish_animation_player, "animation_finished")
	petri_dish_animation_player.play("slide_right_center")
	yield(petri_dish_animation_player, "animation_finished")
	animation_playing = false
	current_level -= 1
	task_name.text = names[current_level]
	task_description.text = descriptions[current_level]
	if mouse_in:
		petri_dish_animation_player.play("open")


func _on_RightArrow_pressed():
	if animation_playing:
		return
	if current_level == CurrentLevel.size() - 1:
		return	
	
	animation_playing = true
	petri_dish_animation_player.play("slide_center_right")
	yield(petri_dish_animation_player, "animation_finished")
	petri_dish_animation_player.play("slide_left_center")
	yield(petri_dish_animation_player, "animation_finished")
	animation_playing = false
	current_level += 1
	task_name.text = names[current_level]
	task_description.text = descriptions[current_level]
	if mouse_in:
		petri_dish_animation_player.play("open")


func _on_Timer_timeout():
	$Bubble.visible = false
