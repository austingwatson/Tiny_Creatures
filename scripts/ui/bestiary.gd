extends Control

export var names = ["", "", "", ""]
export var purple_icon: Texture
export var green_icon: Texture
export var red_icon: Texture
export var yellow_icon: Texture
export var descriptions = ["", "", "", ""]

var creature = Juice.Creature.SLUG

onready var book = $Book/Background
onready var hover_text = $Book/HoverText
onready var pages = $Pages
onready var page_name = $Pages/VBoxContainer/NameBackground/Name
onready var page_text = $Pages/VBoxContainer/TextBackground/Text
onready var prev_page = $Pages/PrevPage
onready var next_page = $Pages/NextPage
onready var icon = $Pages/VBoxContainer/IconBackground/Icon
onready var close_label = $Pages/HBoxContainer/Label
onready var animation_player = $AnimationPlayer


func _ready():
	set_page()
	

func set_page():
	page_name.text = names[creature]
	page_text.text = descriptions[creature]
	
	match creature:
		Juice.Creature.SLUG:
			icon.texture = purple_icon
		Juice.Creature.SLIME:
			icon.texture = green_icon
		Juice.Creature.AMOEBA:
			icon.texture = red_icon
		Juice.Creature.SCARY_BOY:
			icon.texture = yellow_icon
	

func _on_Book_pressed():
	book.visible = false
	hover_text.visible = false
	pages.visible = true
	animation_player.play("open_book")


func _on_Background_mouse_entered():
	hover_text.visible = true


func _on_Background_mouse_exited():
	hover_text.visible = false


func _on_Close_pressed():
	book.visible = true
	#pages.visible = false
	animation_player.play_backwards("open_book")


func _on_PrevPage_pressed():
	creature -= 1
	next_page.visible = true
	if creature <= 0:
		creature = 0
		prev_page.visible = false
	set_page()


func _on_NextPage_pressed():
	creature += 1
	prev_page.visible = true
	if creature >= Juice.Creature.size() - 1:
		creature = Juice.Creature.size() - 1
		next_page.visible = false
	set_page()


func _on_Close_mouse_entered():
	close_label.visible = true


func _on_Close_mouse_exited():
	close_label.visible = false
