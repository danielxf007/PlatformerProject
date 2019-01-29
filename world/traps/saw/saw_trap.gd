extends Node2D

const ANGULAR_SPEED = 2 * PI * 8
const PUSH_FORCE = Vector2(700.0, 0)
export(int) var damage = 10
export(float) var stagger_time = 0.3
var angle

func _ready():
	angle = 0

func _physics_process(delta):
	angle += ANGULAR_SPEED * delta
	angle = fmod(angle, 2 * PI)
	$Saw.rotate(angle)

func _on_StrikeZone_body_entered(body):
	if body.name == "Player":
		body.take_damage(damage, PUSH_FORCE, stagger_time, null)
		$Saw/StrikeZone/CollisionShape2D.disabled = true
		$Saw/CoolDown.start()

func _on_CoolDown_timeout():
	$Saw/StrikeZone/CollisionShape2D.disabled = false
