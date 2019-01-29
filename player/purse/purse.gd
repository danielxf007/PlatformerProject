extends Node
signal cristals_changed(count)

export(int) var cristals = 0

func _ready():
	emit_signal("cristals_changed", cristals)

func take_cristal(amount):
	cristals += amount
	emit_signal("cristals_changed", cristals)
