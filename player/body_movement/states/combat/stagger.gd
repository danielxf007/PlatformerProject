extends "res://player/body_movement/states/state.gd"

const FLOOR_NORMAL = Vector2(0, -1)
const GRAVITY = 300.0
var speed = 0.0
var velocity = Vector2() setget set_velocity, get_velocity
var stagger_time = 0.0 setget set_stagger_time, get_stagger_time
var time = 0.0
var push_force = Vector2() setget set_push_force, get_push_force
var in_stagger_time = 0.0

func enter():
	velocity.y = GRAVITY
	handle_animation("stagger")
	in_stagger_time = 0.0

func exit():
	time = 0.0
	speed = 0.0
	velocity = Vector2(0 ,0)
	stagger_time = 0.0
	in_stagger_time = 0.0

func  update(delta):
	if stagger_time != 0.0:
		time += delta
		if time < stagger_time:
			calculate_velocity(time)
			owner.move_and_slide(velocity)
		else:
			emit_signal("finished", "previous")
	else:
		emit_signal("finished", "previous")

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)

func _on_animation_finished(anim_name):
	pass

func set_push_force(push):
	push_force = push

func get_push_force():
	return push_force

func calculate_velocity(current_time):
	velocity.x = push_force.x * current_time

func set_velocity(_velocity):
	velocity = _velocity

func get_velocity():
	return velocity

func set_stagger_time(_time):
	stagger_time = _time

func get_stagger_time():
	return stagger_time