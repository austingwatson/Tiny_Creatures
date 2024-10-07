class_name ScaryBoyStats
extends Resource

export var speed = 0
export var egg_time = Vector2.ZERO
export var idle_time = Vector2.ZERO
export var scare_time = Vector2.ZERO


func get_random_egg_time():
	return rand_range(egg_time.x, egg_time.y)


func get_random_idle_time():
	return rand_range(idle_time.x, idle_time.y)
	

func get_random_scare_time():
	return rand_range(scare_time.x, scare_time.y)
