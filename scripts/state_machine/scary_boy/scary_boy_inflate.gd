extends "res://scripts/state_machine/state.gd"

const scary_boy_stats = preload("res://resources/scary_boy_stats/scary_boy_stats.tres")

var scary_boy
var animated_sprite: AnimatedSprite

onready var timer = $Timer


func enter(_data):
	animated_sprite.play("inflate")
	timer.start(scary_boy_stats.get_random_inflate_time())
	

func leave():
	timer.stop()
	
	scary_boy.level.set_tile_on(scary_boy.global_position, Tile.Layer.YELLOW)
	for _i in range(16):
		scary_boy.level.set_tile_on(get_random_pos(-64, 64), Tile.Layer.YELLOW)
	

func get_random_pos(min_pos, max_pos):
	return scary_boy.global_position + Vector2(rand_range(min_pos, max_pos), rand_range(min_pos, max_pos))


func _on_Timer_timeout():
	state_machine.enter_state("Dead")
