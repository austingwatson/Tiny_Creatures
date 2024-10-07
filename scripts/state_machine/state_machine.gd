extends Node2D

export var initial_state: String
export var show_state_name = true

onready var current_state = get_node(initial_state)
onready var state_name = $StateName


func init():
	current_state.enter({})
	state_name.text = initial_state
	state_name.visible = show_state_name


func enter_state(state, data = {}):
	current_state.leave()
	current_state = get_node(state)
	state_name.text = state
	current_state.enter(data)
	

func force_state_change(state, blocking_states, data = {}):
	if blocking_states.has(current_state.name):
		return
	enter_state(state, data)
	

func _physics_process(delta):
	current_state.update(delta)
