extends Node2D

func _ready():
	$AnimationPlayer.play("coin")

func _on_Visibility_body_entered(body):
	if body.name == "Player":
		var purse = body.get_node("Purse")
		purse.take_coin(1)
		$Visibility/CollisionShape2D.disabled = true
		queue_free()
