extends KinematicBody2D

const PUSH_FORCE = Vector2(700, 0)
onready var stagger = $BodyMovement/Stagger
onready var health = $Health
export(int) var strike_zone_damage = 2
export(float) var strike_zone_stagger_time = 0.3
export(String) var attack = null
var look_direction = Vector2(1, 0) setget set_look_direction, get_look_direction
var movement_direction = Vector2() setget set_movement_direction, get_movement_direction
var left = false
var right = true
var player_direction
var player
func _ready():
	var weapon_state_machine = $EnemyAttacks.get_node("StateMachine") 
	if not attack  in ["weave", "fire_ball", "blue_fire_ball"]:
		attack = "weave"
		weapon_state_machine._change_state(attack)
	else:
		weapon_state_machine._change_state(attack)
	_randomize_look_direction()
	_randomize_movement_direction()
	for node in  get_tree().get_nodes_in_group("actor"):
		if node.name == "Player":
			player = node
			break 
	player_direction = player.get_look_direction()


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
	$BodyMovement._change_state("stagger")

func set_dead(value):
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
