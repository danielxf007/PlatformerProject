extends "res://enemies/enemy_prototype/body_movement/states/state.gd"

func get_input_direction():
	return owner.get_movement_direction()

func update_look_direction(direction):
	if direction and direction != owner.get_look_direction():
		owner.set_look_direction(direction) 