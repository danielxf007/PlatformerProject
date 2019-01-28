extends "res://attacks/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"weave" : $Weave
	}

func _change_state(state_name):
	._change_state(state_name)
