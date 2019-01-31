extends KinematicBody2D
signal direction_changed(new_direction)
onready var health = $Health
onready var stagger = $StateMachine/Stagger
onready var move = $StateMachine/Move

var look_direction = Vector2(1, 0) setget set_look_direction, get_look_direction

func _ready():
	pass
"""	for node in get_tree().get_nodes_in_group("obstacle"):
		node.connect("body_entered", self, "damaged_by_spikes")"""
	
func take_damage(amount, push_force, stagger_time, effect = null):
	health.take_damage(amount, effect)
	stagger.set_stagger_time(stagger_time)
	var direction_sign = sign(look_direction.x)
	push_force = push_force * -direction_sign
	stagger.set_push_force(push_force)
	$StateMachine._change_state("Stagger")

func set_dead(value):
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionShape2D.disabled = value
	queue_free()

func set_look_direction(value):
	look_direction = value
	$Body.flip_h = value.x < 0
	emit_signal("direction_changed", value)

func get_look_direction():
	return look_direction

func climb(value):
	if value:
		$StateMachine._change_state("Climb")
	elif !value and $StateMachine.current_state.name == "Climb":
		$StateMachine/Climb.stop_climb()

func cure(amount):
	$Health.cure(amount)

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"health" : $Health.health,
		"max_health" : $Health.max_health,
		"current_state" : $StateMachine.current_state.name,
		"cristals" : $Purse.cristals,
		"attack" : $Attacks/StateMachine.current_state.name,
		"look_direction_x" : get_look_direction().x
		}
	return save_dict

func load_content(_dict):
	position = Vector2(_dict["pos_x"], _dict["pos_y"])
	$Health.health = _dict["health"]
	$Health.max_health = _dict["max_health"]
	$Health.change_health()
	$StateMachine._change_state(_dict["current_state"])
	$Purse.cristals = _dict["cristals"]
	$Attacks/StateMachine._change_state(_dict["attack"])
	set_look_direction(Vector2(_dict["look_direction_x"], 0))
