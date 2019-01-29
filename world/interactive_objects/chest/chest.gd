extends Node2D
export(int) var max_number_coins = 10
var coins = 0.0

func _ready():
	coins = randi() % max_number_coins
func _on_InteractiveArea_body_entered(body):
	if body.name == "Player":
		var purse = body.get_node("Purse")
		purse.take_coin(coins)
		$AnimationPlayer.play("dissapear")
		$InteractiveArea/CollisionShape2D.disabled = true
		$Timer.start()


func _on_Timer_timeout():
	queue_free()
