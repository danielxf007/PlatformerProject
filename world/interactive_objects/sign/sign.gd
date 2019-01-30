extends Node2D
signal correct_number_triggered()
signal incorrect_number_triggered()
export(String) var type_of_sign = null
export(int) var correct_number = 0
var current_sign = 0

func _ready():
	correct_number = fmod(correct_number, 6)
	if type_of_sign == null or not type_of_sign in ["0", "1", "2", "3", "4", "5"]:
		type_of_sign = "0"
		handle_animation(type_of_sign)
	else:
		handle_animation(type_of_sign)
	set_process_input(false)
	current_sign = int(type_of_sign)
	
func _input(event):
	if event.is_action_pressed("change_sign"):
		current_sign += 1
		current_sign = fmod(current_sign, 6)
		if current_sign == correct_number:
			emit_signal("correct_number_triggered")
		else:
			emit_signal("incorrect_number_triggered")
		handle_animation(str(current_sign))

func handle_animation(ani_name):
	$AnimationPlayer.play(ani_name)

func _on_ContactZone_body_entered(body):
	set_process_input(true)


func _on_ContactZone_body_exited(body):
	set_process_input(false)

func desactivate_sign():
	$ContactZone.queue_free()
	set_process_input(false)
