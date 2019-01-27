extends "res://player/body_movement/states/motion/motion.gd"

const GRAVITY_ACCELARATION = 300.0
const HORIZONTAL_SPEED = 50
const FLOOR_NORMAL = Vector2(0, -1)
var velocity = Vector2()

func enter():
	velocity.y = 0
	handle_animation("fall")

func update(delta):
	var input_direction = get_input_direction().normalized()
	update_look_direction(input_direction)
	make_fall(input_direction, delta)
	if owner.is_on_floor():
		emit_signal("finished", "previous")

func make_fall(input_direction, delta):
	velocity.x = input_direction.x * HORIZONTAL_SPEED
	velocity.y += GRAVITY_ACCELARATION * delta
	owner.move_and_slide(velocity, Vector2(0, -1))

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)