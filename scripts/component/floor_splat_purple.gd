extends Node2D

onready var medium = $medium_droplets
onready var tiny = $tiny_droplets
onready var big = $big_droplets


func _ready():
	medium.emitting = true
	tiny.emitting = true
	big.emitting = true
	

func _process(_delta):
	if not medium.emitting and not tiny.emitting and not big.emitting:
		queue_free()
