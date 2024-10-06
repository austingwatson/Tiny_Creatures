extends CanvasLayer

signal slug_selected
signal slime_selected
signal amoeba_selected
signal scary_boy_selected

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

onready var slug_juices = [slug_juice1, slug_juice2, slug_juice3]
onready var slime_juices = [slime_juice1, slime_juice2, slime_juice3]
onready var amoeba_juices = [amoeba_juice1, amoeba_juice2, amoeba_juice3]
onready var scary_boy_juices = [scary_boy_juice1, scary_boy_juice2, scary_boy_juice3]
onready var fps = $FPS
onready var slug = $Vials/Slug
onready var slug_label = $Vials/Slug/Sticker/Label
onready var slime = $Vials/Slime
onready var slime_label = $Vials/Slime/Sticker/Label
onready var amoeba = $Vials/Amoeba
onready var amoeba_label = $Vials/Amoeba/Sticker/Label
onready var scary_boy = $Vials/ScaryBoy
onready var scary_boy_label = $Vials/ScaryBoy/Sticker/Label


func _ready():
	fps.visible = show_fps
	slug.texture_progress = slug_juices.pick_random()
	slime.texture_progress = slime_juices.pick_random()
	amoeba.texture_progress = amoeba_juices.pick_random()
	scary_boy.texture_progress = scary_boy_juices.pick_random()


func _process(_delta):
	fps.text = "FPS: " + str(Engine.get_frames_per_second())


func drop_creature():
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
