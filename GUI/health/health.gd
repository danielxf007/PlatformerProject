extends Node

signal health_changed(new_health)
signal cure_health()
export(int) var max_health = 20
var health = 0

func _ready():
	health = max_health
	emit_signal("health_changed", health)

func change_health():
	emit_signal("health_changed", health)
func cure(amount):
	health += amount
	if health > max_health:
		health = max_health
	emit_signal("health_changed", health)

func take_damage(amount, effect):
	health -= amount
	emit_signal("health_changed", health)
	if health <= 0:
		owner.set_dead(true)
	if not effect:
		return