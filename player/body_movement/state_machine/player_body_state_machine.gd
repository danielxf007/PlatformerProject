extends "res://player/body_movement/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"idle" : $Idle,
		"move" : $Move,
		"jump" : $Jump,
		"fall" : $Fall,
		"stagger" : $Stagger,
		"climb" : $Climb
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["jump", "fall", "stagger", "climb"]:
		while states_stack.size() > 1:
			states_stack.pop_back()
		states_stack.push_back(states_map[state_name])
		print(states_stack.size())
	._change_state(state_name)

func _input(event):
	current_state.handle_input(event)