extends "res://attacks/states/state.gd"

var wave = preload("res://attacks/wave/wave_scene/Wave.tscn")

func enter():
	return

func exit():
	return

func update(state_name):
	emit_signal("finished", state_name)

func handle_animation(ani_name):
	return

func _on_animation_finished(anim_name):
	return

func make_attack(direction):
	if not $CoolDownTimer.is_stopped():
		return
	$CoolDownTimer.start()
	var new_wave = wave.instance()
	new_wave.add_collision_exception_with(owner.get_parent()) 
	new_wave.direction = direction
	owner.add_child(new_bullet)