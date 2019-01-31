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
		puzzle_solved = true

func _on_Sign2_number_changed(number, sign_position):
	current_code[sign_position] = number
	if codes_match():
		$Activate.start()
		desactivate_signs()
		puzzle_solved = true

func _on_Sign3_number_changed(number, sign_position):
	current_code[sign_position] = number
	if codes_match():
		$Activate.start()
		desactivate_signs()
		puzzle_solved = true

func _on_Sign4_number_changed(number, sign_position):
	current_code[sign_position] = number
	if codes_match():
		$Activate.start()
		desactivate_signs()
		puzzle_solved = true

func codes_match():
	var code_size = correct_code.size()
	var codes_match = true
	for i in range(0, code_size):
		if current_code[i] != correct_code[i]:
			codes_match = false
			break
	return codes_match

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"correct_code" : correct_code,
		"current_code" : current_code,
		"puzzle_solved" : puzzle_solved
		}
	return save_dict

func actualize_signs():
	var signs = get_node("Signs")
	var signs_children = signs.get_children()
	for child in signs_children:
		child.current_sign = current_code[child.sign_pos]
		child.handle_animation(str(child.current_sign))

func load_content(_dict):
	position = Vector2(_dict["pos_x"], _dict["pos_y"])
	correct_code = _dict["correct_code"]
	current_code = _dict["current_code"]
	puzzle_solved = _dict["puzzle_solved"]
	if puzzle_solved:
		desactivate_signs()
		make_stakes_dissapear()
	else:
		actualize_signs()