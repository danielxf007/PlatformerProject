extends KinematicBody2D

const GRAVITY = 1.0
const HORIZONTAL_SPEED = 300.0
const PUSH_FORCE = 500.0
var damage = 3
var direction
var look_direction = Vector2(-1, 0) setget set_look_direction
var velocity = Vector2()

func _ready():
	set_as_toplevel(true)
	velocity.x = direction.x * HORIZONTAL_SPEED

func _physics_process(delta):
	if is_outside_view_bounds():
		queue_free()
	velocity.y += GRAVITY * delta
	var motion = velocity * delta
	var collision_info = move_and_collide(motion)
	if collision_info:
		var collider = collision_info.collider
		if collider.has_method("take_damage"):
			collider.take_damage(damage, Vector2(PUSH_FORCE, 0), 0.12, null)
		queue_free()

func is_outside_view_bounds():
	var out_x_bound = position.x > OS.get_screen_size().x or position.x < 0.0
	var out_y_bound = position.y > OS.get_screen_size().y or position.y < 0.0
	return out_x_bound or out_y_bound

func set_look_direction(new_direction):
	$Sprite.flip_h = new_direction.x > 0