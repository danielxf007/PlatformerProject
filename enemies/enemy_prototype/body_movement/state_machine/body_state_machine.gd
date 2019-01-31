extends "res://enemies/enemy_prototype/body_movement/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"Idle" : $Idle,
		"Move" : $Move,
		"Fall" : $Fall,
		"Stagger": $Stagger,
	}

func _change_state(state_name):
	if not _active:
		return
	if state_name in ["Fall", "Stagger"]:
		while states_stack.size() > 1:
			states_stack.pop_front()
		states_stack.push_front(states_map[state_name])
	._change_state(state_name)
