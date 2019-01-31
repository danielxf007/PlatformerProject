extends KinematicBody2D

onready var stagger = $BodyMovement/Stagger
onready var health = $Health
export(Vector2) var PUSH_FORCE = Vector2(700, 0)
export(int) var strike_zone_damage = 2
export(float) var strike_zone_stagger_time = 0.3
export(String) var attack = null
var look_direction = Vector2(1, 0) setget set_look_direction, get_look_direction
var movement_direction = Vector2() setget set_movement_direction, get_movement_direction
var left = false
var right = true
var player_direction
var player
var on_screen = true
func _ready():
	var weapon_state_machine = $EnemyAttacks.get_node("StateMachine") 
	if not attack  in ["Weave", "Flame", "BlueFlame"]:
		attack = "Weave"
		weapon_state_machine._change_state(attack)
	else:
		weapon_state_machine._change_state(attack)
	_randomize_look_direction()
	_randomize_movement_direction()



func set_look_direction(direction):
	if direction.x > 0:
		if right == false and left == true:
			$Body.flip_h = false
			look_direction = direction
			right = true
			left = false
	elif direction.x < 0:
		if right == true and left == false:
			$Body.flip_h = true
			look_direction = direction
			right = false
			left = true

func get_look_direction():
	return look_direction

func set_movement_direction(direction):
	movement_direction = direction

func get_movement_direction():
	return movement_direction

func _randomize_look_direction():
	var direction = randi() % 2
	match direction:
		0: set_look_direction(Vector2(-1, 0))
		1: set_look_direction(Vector2(1, 0))

func _randomize_movement_direction():
	var direction = randi() % 2
	match direction:
		0: set_movement_direction(Vector2(-1, 0))
		1: set_movement_direction(Vector2(1, 0))

func take_damage(amount, push_force, stagger_time, effect = null):
	health.take_damage(amount, effect)
	stagger.set_stagger_time(stagger_time)
	var direction_sign = sign(look_direction.x)
	push_force = push_force * -direction_sign
	stagger.set_push_force(push_force)
	$BodyMovement._change_state("Stagger")

func set_dead(value):
	on_screen = false
	set_process_input(not value)
	set_physics_process(not value)
	$CollisionShape2D.disabled = value
	$Visibility.queue_free()
	$DamageZone.queue_free()
	queue_free()

func _on_Player_direction_changed(new_direction):
	player_direction = new_direction


func _on_DamageZone_body_entered(body):
	if body.name == "Player":
		body.take_damage(strike_zone_damage, PUSH_FORCE, strike_zone_stagger_time, null )
		$DamageZone/CollisionShape2D.disabled = true
		$CoolDown.start()

func _on_CoolDown_timeout():
	$DamageZone/CollisionShape2D.disabled = false

func save():
	var save_dict = {
		"filename" : get_filename(),
		"parent" : get_parent().get_path(),
		"pos_x" : position.x, # Vector2 is not supported by JSON
		"pos_y" : position.y,
		"health" : $Health.health,
		"max_health" : $Health.max_health,
		"movement_current_state" : $BodyMovement.current_state.name,
		"attack" : $EnemyAttacks/StateMachine.current_state.name,
		"look_direction_x" : get_look_direction().x,
		"movement_direction_x" : get_movement_direction().x,
		"brain_state" : $Brain.current_state.name,
		"push_force_x" : PUSH_FORCE.x,
		"strike_zone_damage" : strike_zone_damage,
		"strike_zone_stagger_timer" : strike_zone_stagger_time,
		"set_attack" : attack,
		"left" : left,
		"right" :right,
		"on_screen" : on_screen
		}
	return save_dict

func load_content(_dict):
	position = Vector2(_dict["pos_x"], _dict["pos_y"])
	$Health.health = _dict["health"]
	$Health.max_health = _dict["max_health"]
	$BodyMovement._change_state(_dict["movement_current_state"])
	$EnemyAttacks/StateMachine._change_state(_dict["attack"])
	set_look_direction(Vector2(_dict["look_direction_x"], 0))
	set_movement_direction(Vector2(_dict["movement_direction_x"], 0))
	$Brain._change_state(_dict["brain_state"])
	PUSH_FORCE = Vector2(_dict["push_force_x"], 0)
	strike_zone_damage = _dict["strike_zone_damage"]
	strike_zone_stagger_time = _dict["strike_zone_stagger_timer"]
	attack = _dict["set_attack"]
	left = _dict["left"]
	right = _dict["right"]
	on_screen = _dict["on_screen"]
	if ! on_screen:
		set_process_input(false)
		set_physics_process(false)
		$CollisionShape2D.disabled = true
		$Visibility.queue_free()
		$DamageZone.queue_free()
		queue_free()