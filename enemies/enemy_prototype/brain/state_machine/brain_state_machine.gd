extends "res://enemies/enemy_prototype/brain/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"patrol" : $Patrol,
		"attack" : $Attack,
	}

func _change_state(state_name):
	if states_map[state_name] == current_state:
		return
	._change_state(state_name)
