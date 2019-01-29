extends RigidBody2D

const PUSH_FORCE = Vector2(700.0, 0)
export(int) var damage = 10
export(float) var stagger_time = 0.3

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage, PUSH_FORCE, stagger_time, null)
		$Area2D/CollisionShape2D.disabled = true
		$CoolDown.start()


func _on_CoolDown_timeout():
	$Area2D/CollisionShape2D.disabled = false

