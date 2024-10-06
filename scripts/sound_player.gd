extends Node

onready var hatch_sounds = [$HatchSound1, $HatchSound2]


func play_hatch_sound():
	hatch_sounds.pick_random().play()
