extends Node

export(int) var max_health = 10
var health = 0

func _ready():
	health = max_health

func take_damage(amount, effect=null):
	health -= amount
	if health <= 0:
		owner.set_dead(true)
	if not effect:
		return
