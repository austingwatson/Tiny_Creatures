extends Area2D

signal on_goal
signal off_goa


func _on_Goal_body_entered(body):
	if body.creature = Juice.Creature.SLUG:
		


func _on_Goal_body_exited(body):
	pass # Replace with function body.
