extends Node2D
export(int) var max_number_cristals = 10
export(int) var min_number_cristals = 1
var cristals = 0.0
var on_screen = true

func _ready():
	cristals  = randi() % max_number_cristals
	if cristals < min_number_cristals:
		cristals = min_number_cristals

func _on_InteractiveArea_body_entered(body):
	if body.name == "Player":
		var purse = body.get_node("Purse")
		purse.take_cristal(cristals)
		$AnimationPlayer.play("dissapear")
		$InteractiveArea/CollisionShape2D.disabled = true
		on_screen = false
		$Timer.start()

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"on_screen" : on_screen,
		"max_number_cristals" : max_number_cristals,
		"min_number_cristals" : min_number_cristals,
		"cristals" : cristals
		}
	return save_dict

func _on_Timer_timeout():
	queue_free()
