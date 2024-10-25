extends Control

export var names = ["", "", "", ""]
export var descriptions = ["", "", "", ""]

var creature = Juice.Creature.SLUG

onready var book = $Book/Background
onready var hover_text = $Book/HoverText
onready var pages = $Pages
onready var page_name = $Pages/Name
onready var page_text = $Pages/Text
onready var prev_page = $Pages/PrevPage
onready var next_page = $Pages/NextPage


func _ready():
	set_page()
	

func set_page():
	page_name.text = names[creature]
	page_text.text = descriptions[creature]
	

func _on_Book_pressed():
	book.visible = false
	hover_text.visible = false
	pages.visible = true


func _on_Background_mouse_entered():
	hover_text.visible = true


func _on_Background_mouse_exited():
	hover_text.visible = false


func _on_Close_pressed():
	book.visible = true
	pages.visible = false


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
