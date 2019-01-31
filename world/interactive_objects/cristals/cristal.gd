extends Node2D

signal cristal_took(amount) 
var on_screen = true

func initialize():
	if !on_screen:
		get_out_screen()

func get_out_screen():
	$Visibility/CollisionShape2D.disabled = true
	queue_free()

func _on_Visibility_body_entered(body):
	if body.name == "Player":
		var purse = body.get_node("Purse")
		purse.take_cristal(1)
		$Visibility/CollisionShape2D.disabled = true
		on_screen = false
		queue_free()

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
		$Visibility.queue_free()
		queue_free()