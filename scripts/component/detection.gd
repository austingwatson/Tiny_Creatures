extends Area2D

export var detection_size = 0

onready var collision_shape = $CollisionShape2D


func _ready():
	collision_shape.shape.radius = detection_size
	

func enable():
	collision_shape.set_deferred("disabled", false)
	

func disable():
	collision_shape.set_deferred("disabled", true)
