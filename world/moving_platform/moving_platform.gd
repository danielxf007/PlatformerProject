extends Node2D

export(float) var SPEED = 100.0
export(bool) var horizontal_movement = true
var direction
var velocity
var wall_right
var wall_left
var _floor
var ceiling

func _ready():
	wall_right = $Platform/WallRight
	wall_left = $Platform/WallLeft
	_floor = $Platform/Floor
	ceiling = $Platform/Ceiling
	if horizontal_movement:
		wall_right.enabled = true
		wall_left.enabled = true
		direction = Vector2(1, 0)
	else:
		_floor.enabled = true
		ceiling.enabled = true
		direction = Vector2 (0, 1)

func _physics_process(delta):
	handle_movement()
	$Platform.translate(velocity * delta)

func handle_movement():
	if horizontal_movement:
		if wall_right.is_colliding():
			direction = Vector2(-1, 0)
		if wall_left.is_colliding():
			direction = Vector2(1, 0)
	else:
		if _floor.is_colliding():
			direction = Vector2(0, -1)
		if ceiling.is_colliding():
			direction = Vector2(0, 1)
	velocity = direction * SPEED