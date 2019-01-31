extends "res://player/body_movement/states/motion/motion.gd"

const GRAVITY = 300.0
const FLOOR_NORMAL = Vector2(0, -1)
var direction = null setget set_direction, get_direction
var speed = 0.0
var velocity = Vector2(0, 1)

func handle_input(event):
	if event.is_action_pressed("jump"):
		emit_signal("finished", "Jump")

func set_direction(new_direction):
	direction = new_direction

func get_direction():
	return direction