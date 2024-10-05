extends Area2D

export var detection_size = 0


func _ready():
	$CollisionShape2D.shape.radius = detection_size
