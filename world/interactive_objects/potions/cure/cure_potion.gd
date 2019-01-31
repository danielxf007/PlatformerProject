extends Node2D
export(int) var amount = 1
export(int) var max_amount = 10
export(int) var min_amount = 1
var on_screen = true

func _ready():
	amount = randi() % max_amount
	if amount < min_amount:
		amount = min_amount


func _on_Visibility_body_entered(body):
	if body.name == "Player":
		body.cure(amount)
		$Visibility/CollisionShape2D.disabled = true
		on_screen = false
		queue_free()

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"on_screen" : on_screen,
		"amount" : amount,
		"max_amount" : max_amount,
		"min_amount" : min_amount
		}
	return save_dict
