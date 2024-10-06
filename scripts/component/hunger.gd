extends Node

signal dead

var max_hunger = 0
var current_hunger = 0


func start_timer(time):
	$Timer.start(time)


func reset_hunger():
	current_hunger = max_hunger


func feed(amount):
	current_hunger += amount


func _on_Timer_timeout():
	current_hunger -= 1
	if current_hunger <= 0:
		emit_signal("dead")
