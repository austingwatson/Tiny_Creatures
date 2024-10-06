class_name AmoebaStats
extends Resource

export var base_speed = 0
export var lunge_speed = 0
export var egg_time = Vector2.ZERO
export var reproduce_time = Vector2.ZERO
export var dead_time = Vector2.ZERO
export var hunger = Vector2.ZERO
export var food_time = Vector2.ZERO


func get_random_egg_time():
	return rand_range(egg_time.x, egg_time.y)
	

func get_random_reproduce_time():
	return rand_range(reproduce_time.x, reproduce_time.y)
	

func get_random_dead_time():
	return rand_range(dead_time.x, dead_time.y)


func get_random_hunger():
	return ceil(rand_range(hunger.x, hunger.y))


func get_random_food_time():
	return rand_range(food_time.x, food_time.y)
