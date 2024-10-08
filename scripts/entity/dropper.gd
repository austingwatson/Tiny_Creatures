extends Node2D

signal dropper_done(spawn_position)

const juice = preload("res://resources/juice/juice.tres")
const squeeze_speed = 0.25
const follow_speed = 4.0

export(Texture) var slug_liquid
export(Texture) var slime_liquid
export(Texture) var amoeba_liquid
export(Texture) var scary_boy_liquid
export(Texture) var slug_drop
export(Texture) var slime_drop
export(Texture) var amoeba_drop
export(Texture) var scary_boy_drop

onready var liquid = $Liquid
onready var pump = $Pump
onready var pump_start_pos = pump.position
onready var drop = $Drop
onready var change_sound = $ChangeSound
onready var drop_sound = $DropSound
onready var spawn_position = $SpawnPosition

var dropping = false


func _ready():
	liquid.texture_progress = slug_liquid
	drop.texture = slug_drop


func _process(delta):
	if dropping:
		return
	
	var mouse = get_global_mouse_position() - Vector2(0, 16)
	global_position = global_position.linear_interpolate(mouse, delta * follow_speed)
	

func switch_creature(creature):
	match creature:
		-1:
			liquid.texture_progress = null
			liquid.value = 0
			pump.position = Vector2(pump.position.x, pump_start_pos.y)
			return
		juice.Creature.SLUG:
			liquid.texture_progress = slug_liquid
			liquid.max_value = juice.slug_max
			liquid.value = juice.slug
			drop.texture = slug_drop
		juice.Creature.SLIME:
			liquid.texture_progress = slime_liquid
			liquid.max_value = juice.slime_max
			liquid.value = juice.slime
			drop.texture = slime_drop
		juice.Creature.AMOEBA:
			liquid.texture_progress = amoeba_liquid
			liquid.max_value = juice.amoeba_max
			liquid.value = juice.amoeba
			drop.texture = amoeba_drop
		juice.Creature.SCARY_BOY:
			liquid.texture_progress = scary_boy_liquid
			liquid.max_value = juice.scary_boy_max
			liquid.value = juice.scary_boy
			drop.texture = scary_boy_drop
	pump.position = Vector2(pump.position.x, pump_start_pos.y - (liquid.texture_progress.get_size().y * liquid.ratio))
	if liquid.value == 0:
		modulate.a = 0.5
	else:
		modulate.a = 1.0
	if not change_sound.playing and liquid.value > 0:
		change_sound.play()
	

func drop_creature():
	dropping = true
	drop_sound.play()
	create_tween().tween_property(liquid, "value", liquid.value - 1.0, squeeze_speed)
	drop.visible = true
	drop.position = Vector2.ZERO
	create_tween().tween_property(drop, "position", Vector2(0, 9), squeeze_speed)
	var ratio = (liquid.value - 1.0) / liquid.max_value
	var target_pump_pos = Vector2(pump.position.x, pump_start_pos.y - (liquid.texture_progress.get_size().y * (ratio)))
	yield(create_tween().tween_property(pump, "position", target_pump_pos, squeeze_speed), "finished")
	drop.visible = false
	emit_signal("dropper_done", spawn_position.global_position + Vector2(0, 16))
	if liquid.value == 0:
		modulate.a = 0.5
	else:
		modulate.a = 1.0
	dropping = false
