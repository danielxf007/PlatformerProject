extends Node2D

export (int) var detect_radius = 100
var vis_color = Color(.867, .91, .247, 0.1)
var laser_color = Color(1.0, .329, .298)
var target = null
var hit_pos
var can_shoot = true

func _ready():
	var shape = CircleShape2D.new()
	shape.radius = detect_radius
	var visibility = owner.get_node("Visibility")
	visibility.get_node("CollisionShape2D").shape = shape
	print(owner)

func _physics_process(delta):
	if target:
		aim()

func aim():
	face_target(target)
	var target_pos = target.global_position
	var robot_pos = owner.global_position
	var attacks_state_machine = owner.get_node("EnemyAttacks").get_node("StateMachine")
	var attack = attacks_state_machine.current_state
	if attack != null:
		var pos = target_pos.x - robot_pos.x
		var pos_sign = sign(pos)
		var shot_direction = Vector2(1 * pos_sign, 0)
		attack.make_attack(shot_direction)
"""	hit_pos = []
	var space_state = get_world_2d().direct_space_state
	var target_extents = target.get_node('CollisionShape2D').shape.extents - Vector2(5, 5)
	var nw = target.position - target_extents
	var se = target.position + target_extents
	var ne = target.position + Vector2(target_extents.x, -target_extents.y)
	var sw = target.position + Vector2(-target_extents.x, target_extents.y)
	for pos in [target.position, nw, ne, se, sw]:
		var result = space_state.intersect_ray(owner.position,
				pos, [owner], owner.collision_mask)
		if result:
			hit_pos.append(result.position)
			if result.collider.name == "Player":
				var weapon_state_machine = owner.get_node("RobotOneWeapons").get_node("StateMachine")
				var weapon = weapon_state_machine.current_state
				if weapon != null:
					var look_direction_sign = sign(owner.get_look_direction().x)
					pos.x = pos.x * look_direction_sign
					var brain = owner.get_node("Brain")
					brain._change_state("attack")
					weapon.shot(pos.normalized())
					break"""

func _draw():
	draw_circle(Vector2(), detect_radius, vis_color)

func _on_Visibility_body_entered(body):
	if target != null or body.name != "Player":
		return
	target = body
	face_target(target)
	var brain = owner.get_node("Brain")
	brain._change_state("attack")

func face_target(target):
	var robot_pos = owner.global_position
	var target_pos = target.global_position
	var direction = Vector2(target_pos.x - robot_pos.x,0).normalized()
	owner.set_look_direction(direction)

func _on_Visibility_body_exited(body):
	if body == target:
		target = null
		var brain = owner.get_node("Brain")
		brain._change_state("patrol")
