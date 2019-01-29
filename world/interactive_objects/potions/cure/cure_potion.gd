extends Node2D
export(int) var amount = 1
export(int) var max_amount = 10
export(int) var min_amount = 1

func _ready():
	amount = randi() % max_amount
	if amount < min_amount:
		amount = min_amount


func _on_Visibility_body_entered(body):
	if body.name == "Player":
		body.cure(amount)
		$Visibility/CollisionShape2D.disabled = true
		queue_free()
