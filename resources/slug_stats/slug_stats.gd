class_name SlugStats
extends Resource

export var base_speed = 0
export var flee_speed = 0
export var egg_time = Vector2.ZERO
export var idle_time = Vector2.ZERO
export var move_time = Vector2.ZERO
export var flee_time = Vector2.ZERO
export var dead_time = Vector2.ZERO


func get_random_egg_time():
	return rand_range(egg_time.x, egg_time.y)
	

func get_random_idle_time():
	return rand_range(idle_time.x, idle_time.y)
	

func get_random_move_time():
	return rand_range(move_time.x, move_time.y)
	

func get_random_flee_time():
	return rand_range(flee_time.x, flee_time.y)
	

func get_random_dead_time():
	return rand_range(dead_time.x, dead_time.y)
