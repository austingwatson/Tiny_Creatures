extends Node2D

signal done

onready var animation_player = $AnimationPlayer


func start_animation():
	animation_player.play("close")
	Engine.time_scale = 1


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "close":
		animation_player.play("RESET")
		emit_signal("done")
