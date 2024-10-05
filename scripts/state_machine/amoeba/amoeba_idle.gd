extends "res://scripts/state_machine/state.gd"

func _on_area_entered(area):
	state_machine.enter_state("MoveTo", {"slime": area})
