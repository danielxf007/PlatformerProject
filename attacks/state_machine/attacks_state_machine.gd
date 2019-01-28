extends "res://attacks/state_machine/state_machine.gd"

func _ready():
	states_map = {
		"weave" : $Weave,
		"blue_flame" : $BlueFlame,
		"flame" : $Flame
	}

func _change_state(state_name):
	._change_state(state_name)
