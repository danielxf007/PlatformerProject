extends Node2D
signal number_changed(number, sign_position)
const MIN_SIGNS_CAN_CHANGE = 1
const MIN_SIG_NUMBER = 0
export(String) var type_of_sign = null
export(int) var sign_pos = 0
export(int) var amount_can_change = 1
export(int) var max_number_of_signs = 6
export(Array) var signs = []
var current_sign = 0

func _ready():
	if type_of_sign == null or not type_of_sign in ["0", "1", "2", "3", "4", "5"]:
		type_of_sign = "0"
		handle_animation(type_of_sign)
	else:
		handle_animation(type_of_sign)
	set_process_input(false)
	current_sign = int(type_of_sign)
	if amount_can_change > max_number_of_signs:
		amount_can_change = max_number_of_signs -1


func _input(event):
	if event.is_action_pressed("change_sign"):
		change_other_signs()
	if event.is_action_pressed("reset_sign"):
		reset_sign()

func handle_animation(ani_name):
	$AnimationPlayer.play(ani_name)

func _on_ContactZone_body_entered(body):
	set_process_input(true)


func _on_ContactZone_body_exited(body):
	set_process_input(false)

func change_sign(amout_to_change):
	current_sign += amout_to_change
	if current_sign < MIN_SIG_NUMBER:
		current_sign = MIN_SIG_NUMBER
	current_sign = fmod(current_sign, max_number_of_signs)
	emit_signal("number_changed", current_sign, sign_pos)
	handle_animation(str(current_sign))

func change_other_signs():
	var parent = owner.get_node("Signs")
	for s in signs:
		var _sign = parent.get_node(s)
		_sign.change_sign(amount_can_change)

func reset_sign():
	handle_animation(type_of_sign)
	current_sign = int(type_of_sign)

func desactivate_sign():
	$ContactZone.queue_free()
	set_process_input(false)
