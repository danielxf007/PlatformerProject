extends "res://enemies/enemy_prototype/attacks/state/state.gd"

var wave = preload("res://attacks/wave/wave_scene/Wave.tscn")

func enter():
		set_owner(get_parent().get_parent().get_parent())

func exit():
	return

func update(state_name):
	emit_signal("finished", state_name)

func handle_animation(ani_name):
	return

func handle_input(event):
	return

func _on_animation_finished(anim_name):
	return

func make_attack(direction):
	if not $CoolDownTimer.is_stopped():
		return
	$CoolDownTimer.start()
	var new_wave = wave.instance()
	new_wave.set_look_direction(direction)
	new_wave.add_collision_exception_with(owner) 
	new_wave.direction = direction
	owner.add_child(new_wave)