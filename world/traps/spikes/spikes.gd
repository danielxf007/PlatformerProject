extends RigidBody2D

var PUSH_FORCE = Vector2(700.0, 0)
export(int) var damage = 10
export(float) var stagger_time = 0.3

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage, PUSH_FORCE, stagger_time, null)
		$Area2D/CollisionShape2D.disabled = true
		$CoolDown.start()


func _on_CoolDown_timeout():
	$Area2D/CollisionShape2D.disabled = false

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"push_force_x" : PUSH_FORCE.x,
		"damage" : damage,
		"stagger_time" : stagger_time
		}
	return save_dict

func load_content(_dict):
	position = Vector2(_dict["pos_x"], _dict["pos_y"])
	PUSH_FORCE = Vector2(_dict["push_force_x"], 0)
	damage = _dict["damage"]
	stagger_time = _dict["stagger_time"]