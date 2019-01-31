extends "res://attacks/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"Weave" : $Weave,
		"BlueFlame" : $BlueFlame,
		"Flame" : $Flame
	}

func _change_state(state_name):
	._change_state(state_name)
