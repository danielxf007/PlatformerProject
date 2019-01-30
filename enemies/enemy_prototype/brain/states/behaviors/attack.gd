extends "res://enemies/enemy_prototype/brain/states/state.gd"

onready var decisions = ["idle", "move", "fall"]
var body_movement
var detect_floor_left
var detect_wall_left
var detect_floor_right
var detect_wall_right
var body_movement_state

func enter():
	set_owner(get_parent().get_parent())
	body_movement = owner.get_node("BodyMovement")
	detect_floor_left = owner.get_node("DetectFloorLeft")
	detect_wall_left = owner.get_node("DetectWallLeft")
	detect_floor_right = owner.get_node("DetectFloorRight")
	detect_wall_right = owner.get_node("DetectWallRight")
	body_movement._change_state("idle")
	body_movement_state = body_movement.current_state

func exit():
	body_movement_state = null

func update(state_name):
	emit_signal("finished", state_name)

func move_body(delta):
	if body_movement_state != body_movement.current_state:
		body_movement_state = body_movement.current_state
	body_movement_state.update(delta)

func change_look_direction(direction):
	owner.set_look_direction(direction)

func handle_normal_movement():
	pass

func handle_periodic_movement():
	return
func change_weapon(weapon_name):
	return

func handle_animation(ani_name):
	return

func _on_animation_finished(anim_name):
	return
