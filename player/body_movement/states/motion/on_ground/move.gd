extends "res://player/body_movement/states/motion/on_ground/on_ground.gd"

const MAX_WALKING_SPEED = 150.0
const WALKING_FORCE = 1000.0
var friction_force = 300.0 setget set_friction
var total_force = 0.0

func enter():
	velocity = Vector2()
	calculate_total_force()
	handle_animation("walk")

func exit():
	speed = 0.0
	velocity = null
	direction = null

func handle_input(event):
	return .handle_input(event)

func update(delta):
	direction = get_input_direction()
	if not direction:
		emit_signal("finished", "Idle")
	else:
		update_look_direction(direction)
		move(direction, delta)

func move(input_direction, delta):
	calculate_speed(input_direction, delta)
	velocity.x = speed
	velocity.y = GRAVITY
	owner.move_and_slide(velocity, FLOOR_NORMAL)
	if not owner.is_on_floor():
		emit_signal("finished", "Fall")

func calculate_speed(input_direction, delta):
	var acceleration =  total_force * input_direction.x
	speed += acceleration * delta
	if  speed > MAX_WALKING_SPEED:
		speed = MAX_WALKING_SPEED
	elif speed < -MAX_WALKING_SPEED:
		speed = -MAX_WALKING_SPEED

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)

func calculate_total_force():
	total_force = WALKING_FORCE - friction_force

func set_friction(new_friction):
	friction_force = new_friction