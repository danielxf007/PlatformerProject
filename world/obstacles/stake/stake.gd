extends Node2D

func dissapear():
	$Dissapear.start()
	handle_animation("disappear")


func handle_animation(ani_name):
	$AnimationPlayer.play(ani_name)

func _on_Dissapear_timeout():
	$Sprite/StaticBody2D/CollisionShape2D.disabled = true
	queue_free()
