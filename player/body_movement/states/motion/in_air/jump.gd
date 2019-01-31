extends "res://player/body_movement/states/motion/motion.gd"

const GRAVITY_ACCELARATION = 300.0
const VERTICAL_SPEED = 150
const HORIZONTAL_SPEED = 100
const FLOOR_NORMAL = Vector2(0, -1)
var velocity = Vector2()
var time_v_is_zero
var on_air_time

func enter():
	on_air_time = 0.0
	velocity.x = 0.0
	velocity.y = -VERTICAL_SPEED
	time_v_is_zero = calculate_time_v_zero(VERTICAL_SPEED)
	handle_animation("jump")

func update(delta):
	on_air_time += delta
	var input_direction = get_input_direction().normalized()
	update_look_direction(input_direction)
	make_jump(input_direction, on_air_time, delta)
	if owner.is_on_floor():
		emit_signal("finished", "previous")
	if owner.is_on_ceiling():
		var state_machine = get_parent()
		emit_signal("finished", "Fall")

func make_jump(input_direction, on_air_t, delta):
	velocity.x = input_direction.x * HORIZONTAL_SPEED
	velocity.y += GRAVITY_ACCELARATION * delta
	if on_air_t >= time_v_is_zero:
		handle_animation("fall")
	owner.move_and_slide(velocity, FLOOR_NORMAL)

func calculate_time_v_zero(v_speed):
	var time = v_speed / GRAVITY_ACCELARATION
	return time

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)