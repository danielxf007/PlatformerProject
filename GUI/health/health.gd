extends Node

signal health_changed(new_health)
export(int) var max_health = 20
var health = 0

func _ready():
	health = max_health
	emit_signal("health_changed", max_health)

func take_damage(amount, effect):
	health -= amount
	emit_signal("health_changed", health)
	if health <= 0:
		owner.set_dead(true)
	if not effect:
		return