extends Node2D
signal saved()
signal saving()

var on_screen = true

func save_game():
	var save_game = File.new()
	save_game.open("res://save/savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	on_screen = false
	for node in save_nodes:
		var node_data = node.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()
	$AnimationPlayer.play("dissapear")
	$Dissapear.start()

func _input(event):
	if event.is_action_pressed("save"):
		save_game()

func _on_Dissapear_timeout():
	emit_signal("saved")
	$Area2D.queue_free()
	queue_free()


func _on_Area2D_body_entered(body):
	set_process_input(true)

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"on_screen" : on_screen
		}
	return save_dict

func load_content(_dict):
	position = Vector2(_dict["pos_x"], _dict["pos_y"])
	on_screen = _dict["on_screen"]
	if !on_screen:
		$Area2D.queue_free()
		queue_free()

func _on_Area2D_body_exited(body):
	set_process_input(false)
