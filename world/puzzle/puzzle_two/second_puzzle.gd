extends Node2D

export(Array) var correct_code = []
var current_code = []
var puzzle_solved = false

func _ready():
	if puzzle_solved:
		make_stakes_dissapear()
		desactivate_signs()
	else:
		var signs = get_node("Signs")
		var signs_children = signs.get_children()
		for node in signs_children:
			current_code.push_back(node.current_sign)

func _on_Activate_timeout():
	make_stakes_dissapear()

func make_stakes_dissapear():
	$Stake.dissapear()
	$Stake2.dissapear()
	$Stake3.dissapear()

func desactivate_signs():
	var signs = get_node("Signs")
	var signs_children = signs.get_children()
	for child in signs_children:
		child.desactivate_sign()



func _on_Sign_number_changed(number, sign_position):
	current_code[sign_position] = number
	if codes_match():
		$Activate.start()
		desactivate_signs()


func _on_Sign2_number_changed(number, sign_position):
	current_code[sign_position] = number
	if codes_match():
		$Activate.start()
		desactivate_signs()


func _on_Sign3_number_changed(number, sign_position):
	current_code[sign_position] = number
	if codes_match():
		$Activate.start()
		desactivate_signs()


func _on_Sign4_number_changed(number, sign_position):
	current_code[sign_position] = number
	if codes_match():
		$Activate.start()
		desactivate_signs()



func _on_Sign5_number_changed(number, sign_position):
	current_code[sign_position] = number
	if codes_match():
		$Activate.start()
		desactivate_signs()

func codes_match():
	var code_size = correct_code.size()
	var codes_match = true
	for i in range(0, code_size):
		if current_code[i] != correct_code[i]:
			codes_match = false
			break
	return codes_match
