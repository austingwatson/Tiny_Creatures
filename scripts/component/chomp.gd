extends Area2D

export var chomp_range = 0

onready var hit_sound = $HitSound


func _ready():
	$CollisionShape2D.shape.radius = chomp_range
	

func hit():
	hit_sound.play()
