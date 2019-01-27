extends Node2D

const PUSH_FORCE = 200.0
var damage = 2

func _ready():
	$AnimationPlayer.play("normal")
	$ActiveTime.start()

func _on_StrikeArea_body_entered(body):
	if body.has_method("take_damage"):
		return


func _on_ActiveTime_timeout():
	set_process_input(not value)
	set_physics_process(not value)
	$StrikeArea.queue_free()
	queue_free()
