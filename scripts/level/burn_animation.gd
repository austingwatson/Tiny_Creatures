extends Node2D

signal done
signal lid_down

onready var animation_player = $AnimationPlayer


func start_animation():
	animation_player.play("drop")
	

func play_sound():
	$BurnSound.play()


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "drop":
		animation_player.play("lift")
		emit_signal("lid_down")
	elif anim_name == "lift":
		animation_player.play("RESET")
		emit_signal("done")
