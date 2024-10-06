extends CanvasLayer

signal slug_selected
signal slime_selected
signal amoeba_selected

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

onready var slug_juices = [slug_juice1, slug_juice2, slug_juice3]
onready var slime_juices = [slime_juice1, slime_juice2, slime_juice3]
onready var amoeba_juices = [amoeba_juice1, amoeba_juice2, amoeba_juice3]
onready var fps = $FPS
onready var slug = $Vials/Slug
onready var slug_label = $Vials/Slug/Sticker/Label
onready var slime = $Vials/Slime
onready var slime_label = $Vials/Slime/Sticker/Label
onready var amoeba = $Vials/Amoeba
onready var amoeba_label = $Vials/Amoeba/Sticker/Label


func _ready():
	fps.visible = show_fps
	slug.texture_progress = slug_juices.pick_random()
	slime.texture_progress = slime_juices.pick_random()
	amoeba.texture_progress = amoeba_juices.pick_random()


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


func _on_Timer_timeout():
	slug.texture_progress = slug_juices.pick_random()
	slime.texture_progress = slime_juices.pick_random()
	amoeba.texture_progress = amoeba_juices.pick_random()


func _on_Slug_gui_input(event):
	if event.is_action_released("click_vial"):
		emit_signal("slug_selected")


func _on_Slime_gui_input(event):
	if event.is_action_released("click_vial"):
		emit_signal("slime_selected")


func _on_Amoeba_gui_input(event):
	if event.is_action_released("click_vial"):
		emit_signal("amoeba_selected")
