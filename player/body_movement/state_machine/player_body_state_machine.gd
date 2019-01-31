extends "res://player/body_movement/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"Idle" : $Idle,
		"Move" : $Move,
		"Jump" : $Jump,
		"Fall" : $Fall,
		"Stagger" : $Stagger,
		"Climb" : $Climb
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["Jump", "Fall", "Stagger", "Climb"]:
		while states_stack.size() > 1:
			states_stack.pop_back()
		states_stack.push_back(states_map[state_name])
	._change_state(state_name)

func _input(event):
	current_state.handle_input(event)