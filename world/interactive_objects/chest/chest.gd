extends Node2D
export(int) var max_number_cristals = 10
export(int) var min_number_cristals = 1
var cristals = 0.0

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
		$Timer.start()


func _on_Timer_timeout():
	queue_free()
