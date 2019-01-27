extends "res://attacks/states/state.gd"
var strike = preload("res://attacks/strike/strike_scene/Strike.tscn")
onready var attacks_owner = owner.get_parent() 
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

func make_attack():
	if not $CoolDownTimer.is_stopped():
		return
	$CoolDownTimer.start()
	var new_strike = strike.instance()
	var strike_zone = new_strike.get_node("StrikeArea")
	strike_zone.add_collision_exception_with(attacks_owner)
	owner.add_child(new_strike)
