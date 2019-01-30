extends Node2D

var correct_number_sign = false 
var correct_number_sign2 = false 
var correct_number_sign3 = false 
var correct_number_sign4 = false 


func _on_Sign_correct_number_triggered():
	correct_number_sign = true
	if correct_number_sign and correct_number_sign2 and correct_number_sign3 and correct_number_sign4:
		$Activate.start()
		desactivate_signs()



func _on_Sign2_correct_number_triggered():
	correct_number_sign2 = true
	if correct_number_sign and correct_number_sign2 and correct_number_sign3 and correct_number_sign4:
		$Activate.start()
		desactivate_signs()

func _on_Sign3_correct_number_triggered():
	correct_number_sign3 = true
	if correct_number_sign and correct_number_sign2 and correct_number_sign3 and correct_number_sign4:
		$Activate.start()
		desactivate_signs()

func _on_Sign4_correct_number_triggered():
	correct_number_sign4 = true
	if correct_number_sign and correct_number_sign2 and correct_number_sign3 and correct_number_sign4:
		$Activate.start()
		desactivate_signs()

func _on_Activate_timeout():
	$Stake.dissapear()
	$Stake2.dissapear()
	$Stake3.dissapear()


func _on_Sign_incorrect_number_triggered():
	correct_number_sign = false


func _on_Sign2_incorrect_number_triggered():
	correct_number_sign2 = false


func _on_Sign3_incorrect_number_triggered():
	correct_number_sign3 = false


func _on_Sign4_incorrect_number_triggered():
	correct_number_sign4 = false

func desactivate_signs():
	for child in get_children():
		if child in [$Sign, $Sign2, $Sign3, $Sign4]:
			child.desactivate_sign()