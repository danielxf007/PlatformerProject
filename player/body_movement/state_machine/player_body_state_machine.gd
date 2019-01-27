extends "res://player/body_movement/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"idle" : $Idle,
		"move" : $Move,
		"jump" : $Jump,
		"fall" : $Fall,
		"stagger" : $Stagger,
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["jump", "fall", "stagger"]:
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)

func _input(event):
	current_state.handle_input(event)