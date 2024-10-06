extends Area2D

export var chomp_range = 0


func _ready():
	$CollisionShape2D.shape.radius = chomp_range
