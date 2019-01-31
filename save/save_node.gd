extends Node2D

var on_screen = true

func save_game():
	var save_game = File.new()
	save_game.open("res://save/savegame.save", File.WRITE)
	var save_nodes = get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		var node_data = node.call("save")
		save_game.store_line(to_json(node_data))
	save_game.close()
	on_screen = false
	$AnimationPlayer.play("dissapear")
	$Dissapear.start()



func _on_Dissapear_timeout():
	$Area2D.queue_free()
	queue_free()


func _on_Area2D_body_entered(body):
	save_game()

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"on_screen" : on_screen
		}
	return save_dict
