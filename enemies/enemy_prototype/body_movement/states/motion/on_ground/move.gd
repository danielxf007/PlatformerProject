extends "res://enemies/enemy_prototype/body_movement/states/motion/on_ground/on_ground.gd"

const MAX_WALKING_SPEED = 150.0
const FLOOR_NORMAL = Vector2(0, -1)

func enter():
	handle_animation("walk")

func update(delta):
	var input_direction = get_input_direction()
	if input_direction == Vector2(0, 0):
		emit_signal("finished", "Idle")
	else:
		update_look_direction(input_direction)
		move(input_direction, delta)

func move(direction, delta):
	velocity = direction.normalized() * MAX_WALKING_SPEED
	velocity.y = GRAVITY
	owner.move_and_slide(velocity, FLOOR_NORMAL)
	if not owner.is_on_floor():
		emit_signal("finished", "Fall")


func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)