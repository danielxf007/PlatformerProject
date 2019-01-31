extends Control
signal health_changed(new_health)
signal cristals_changed(count)

func _ready():
	var health_node = null
	for node in get_tree().get_nodes_in_group("actor"):
		if node.name == "Player":
			health_node = node.get_node("Health")
			break
	get_node("Bars/LifeBar").initialize(health_node.max_health)


func _on_Health_health_changed(new_health):
	emit_signal("health_changed", new_health)


func _on_Purse_cristals_changed(count):
	emit_signal("cristals_changed", count)
