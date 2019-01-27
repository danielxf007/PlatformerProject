extends "res://player/body_movement/states/motion/on_ground/on_ground.gd"

func enter():
	velocity = Vector2()
	handle_animation("idle")

func exit():
	velocity = null

func handle_input(event):
	return .handle_input(event)

func update(delta):
	var input_direction = get_input_direction()
	if input_direction:
		emit_signal("finished", "move")
	velocity.y = direction.y * GRAVITY
	velocity.x = direction.x * speed
	owner.move_and_slide(velocity, FLOOR_NORMAl)

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)