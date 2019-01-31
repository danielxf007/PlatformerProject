extends "res://enemies/enemy_prototype/body_movement/states/motion/on_ground/on_ground.gd"

const FLOOR_NORMAL = Vector2(0, -1)
const GRAVITY = 300.0
func enter():
	velocity = Vector2(0, GRAVITY)
	handle_animation("idle")

func update(delta):
	var input_direction = get_input_direction()
	if input_direction.x != 0 and input_direction.y != 0:
		emit_signal("finished", "Move")
	else:
		owner.move_and_slide(velocity, FLOOR_NORMAL)
		if not owner.is_on_floor():
			emit_signal("finished", "Fall")

func handle_animation(ani_name):
	owner.get_node("AnimationPlayer").play(ani_name)