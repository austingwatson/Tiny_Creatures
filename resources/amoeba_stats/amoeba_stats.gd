class_name AmoebaStats
extends Resource

export var egg_time = Vector2.ZERO
export var reproduce_time = Vector2.ZERO


func get_random_egg_time():
	return rand_range(egg_time.x, egg_time.y)
	

func get_random_reproduce_time():
	return rand_range(reproduce_time.x, reproduce_time.y)
