extends "res://attacks/states/state.gd"
var strike = preload("res://attacks/strike/strike_scene/Strike.tscn")
func enter():
	set_owner(get_parent().get_parent().get_parent())

func exit():
	return

func update(state_name):
	emit_signal("finished", state_name)

func handle_input(event):
	return

func handle_animation(ani_name):
	return

func _on_animation_finished(anim_name):
	return

func make_attack():
	if not $CoolDownTimer.is_stopped():
		return
	$CoolDownTimer.start()
	var new_strike = strike.instance()
	var strike_zone = new_strike.get_node("StrikeArea")
	owner.add_child(new_strike)
