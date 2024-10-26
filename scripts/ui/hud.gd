extends CanvasLayer

signal slug_selected
signal slime_selected
signal amoeba_selected
signal scary_boy_selected
signal reset
signal level_select

const juice = preload("res://resources/juice/juice.tres")

export var show_fps = true
export(Texture) var slug_juice1
export(Texture) var slug_juice2
export(Texture) var slug_juice3
export(Texture) var slime_juice1
export(Texture) var slime_juice2
export(Texture) var slime_juice3
export(Texture) var amoeba_juice1
export(Texture) var amoeba_juice2
export(Texture) var amoeba_juice3
export(Texture) var scary_boy_juice1
export(Texture) var scary_boy_juice2
export(Texture) var scary_boy_juice3

export(Texture) var speed_setting1_normal
export(Texture) var speed_setting1_hover
export(Texture) var speed_setting2_normal
export(Texture) var speed_setting2_hover
export(Texture) var speed_setting3_normal
export(Texture) var speed_setting3_hover

var current_speed_setting = 1

onready var slug_juices = [slug_juice1, slug_juice2, slug_juice3]
onready var slime_juices = [slime_juice1, slime_juice2, slime_juice3]
onready var amoeba_juices = [amoeba_juice1, amoeba_juice2, amoeba_juice3]
onready var scary_boy_juices = [scary_boy_juice1, scary_boy_juice2, scary_boy_juice3]
onready var fps = $FPS
onready var slug = $BottomPanel/Vials/Slug
onready var slug_label = $BottomPanel/Vials/Slug/Sticker/Label
onready var slime = $BottomPanel/Vials/Slime
onready var slime_label = $BottomPanel/Vials/Slime/Sticker/Label
onready var amoeba = $BottomPanel/Vials/Amoeba
onready var amoeba_label = $BottomPanel/Vials/Amoeba/Sticker/Label
onready var scary_boy = $BottomPanel/Vials/ScaryBoy
onready var scary_boy_label = $BottomPanel/Vials/ScaryBoy/Sticker/Label
onready var speed_setting = $SpeedSetting
onready var reset_label = $BottomPanel/Reset/Label
onready var level_select_label = $BottomPanel/LevelSelect/Label


func _ready():
	fps.visible = show_fps
	slug.texture_progress = slug_juices.pick_random()
	slime.texture_progress = slime_juices.pick_random()
	amoeba.texture_progress = amoeba_juices.pick_random()
	scary_boy.texture_progress = scary_boy_juices.pick_random()
	
	speed_setting.texture_normal = speed_setting1_normal
	speed_setting.texture_hover = speed_setting1_hover


func _process(_delta):
	fps.text = "FPS: " + str(Engine.get_frames_per_second())


func drop_creature():
	if juice.slug_max == 0:
		slug.visible = false
	if juice.slime_max == 0:
		slime.visible = false
	if juice.amoeba_max == 0:
		amoeba.visible = false
	if juice.scary_boy_max == 0:
		scary_boy.visible = false
	
	slug.max_value = juice.slug_max
	slug.value = juice.slug
	slug_label.text = str(juice.slug)
	
	slime.max_value = juice.slime_max
	slime.value = juice.slime
	slime_label.text = str(juice.slime)
	
	amoeba.max_value = juice.amoeba_max
	amoeba.value = juice.amoeba
	amoeba_label.text = str(juice.amoeba)
	
	scary_boy.max_value = juice.scary_boy_max
	scary_boy.value = juice.scary_boy
	scary_boy_label.text = str(juice.scary_boy)
	

func set_speed_setting(speed_setting):
	match speed_setting:
		1:
			Engine.time_scale = 1
			self.speed_setting.texture_normal = speed_setting1_normal
			self.speed_setting.texture_hover = speed_setting1_hover
		2:
			Engine.time_scale = 3
			self.speed_setting.texture_normal = speed_setting2_normal
			self.speed_setting.texture_hover = speed_setting2_hover
		3:
			Engine.time_scale = 6
			self.speed_setting.texture_normal = speed_setting3_normal
			self.speed_setting.texture_hover = speed_setting3_hover


func _on_Timer_timeout():
	slug.texture_progress = slug_juices.pick_random()
	slime.texture_progress = slime_juices.pick_random()
	amoeba.texture_progress = amoeba_juices.pick_random()
	scary_boy.texture_progress = scary_boy_juices.pick_random()


func _on_Slug_gui_input(event):
	if event.is_action_released("click_vial"):
		emit_signal("slug_selected")


func _on_Slime_gui_input(event):
	if event.is_action_released("click_vial"):
		emit_signal("slime_selected")


func _on_Amoeba_gui_input(event):
	if event.is_action_released("click_vial"):
		emit_signal("amoeba_selected")


func _on_ScaryBoy_gui_input(event):
	if event.is_action_released("click_vial"):
		emit_signal("scary_boy_selected")


func _on_Reset_pressed():
	emit_signal("reset")


func _on_SpeedSetting_pressed():
	current_speed_setting += 1
	if current_speed_setting > 3:
		current_speed_setting = 1
	set_speed_setting(current_speed_setting)


func _on_Reset_mouse_entered():
	reset_label.visible = true


func _on_Reset_mouse_exited():
	reset_label.visible = false


func _on_LevelSelect_mouse_entered():
	level_select_label.visible = true


func _on_LevelSelect_mouse_exited():
	level_select_label.visible = false


func _on_LevelSelect_pressed():
	emit_signal("level_select")
