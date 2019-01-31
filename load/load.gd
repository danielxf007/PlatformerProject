extends Node2D

var _load = true

func _input(event):
	if $LoadTimer.is_stopped():
		if event.is_action_pressed("load_game"):
			load_game()
			$LoadTimer.start()

func load_game():
	var save_game = File.new()
	if not save_game.file_exists("res://save/savegame.save"):
		print("The file does not exists")
		return
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	#This is done to avoid cloning the nodes
	for node in save_nodes:
		node.queue_free()
 # Load the file line by line and process that dictionary to restore
    # the object it represents.
	save_game.open("res://save/savegame.save", File.READ)
	var current_line = parse_json(save_game.get_line())
	while current_line != null:
		var scene = current_line["filename"]
		var new_object = load(scene).instance()
		owner.get_node(current_line["parent"]).add_child(new_object)
		new_object.load_content(current_line)
		current_line = parse_json(save_game.get_line())
	save_game.close()
