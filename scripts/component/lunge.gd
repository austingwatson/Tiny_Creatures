extends Area2D

export var lunge_size = 0


func _ready():
	$CollisionShape2D.shape.radius = lunge_size
