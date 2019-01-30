extends "res://player/body_movement/states/state.gd"

const CLIMB_SPEED = 100.0
const GRAVITY = 300.0
const HORIZONTAL_SPEED = 50.0
const FLOOR_NORMAL = Vector2(0, -1)
var velocity = Vector2()
 
func enter():
	handle_animation("climb")

func exit():
	return

func handle_input(event):
	return

func update(delta):
	var input_direction = get_input_direction()
	velocity.x = input_direction.x * HORIZONTAL_SPEED
	velocity.y = input_direction.y * CLIMB_SPEED
	owner.move_and_slide(velocity, FLOOR_NORMAL)

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)

func _on_animation_finished(anim_name):
	return

func get_input_direction():
	var input_direction = Vector2()
	input_direction.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	input_direction.y = int(Input.is_action_pressed("climb_down")) - int(Input.is_action_pressed("climb_up"))
	return input_direction

func stop_climb():
	emit_signal("finished", "previous")