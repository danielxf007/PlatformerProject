extends HBoxContainer
signal maximum_changed(maximum)
var maximun_value = 20
var current_health = 0

func initialize(maximun):
	maximun_value = maximun
	emit_signal("maximum_changed", maximun_value)


func _on_Interface_health_changed(new_health):
	animate_value(current_health, new_health)
	update_count_text(new_health)
	current_health = new_health

func animate_value(start, end):
	$Tween.interpolate_property($TextureProgress, "value", start, end, 0.6, Tween.TRANS_ELASTIC, Tween.EASE_OUT)
	$Tween.interpolate_method(self, "update_count_text", start, end, 0.6, Tween.TRANS_EXPO, Tween.EASE_OUT)
	$Tween.start()
	if end < start:
		$AnimationPlayer.play("shake")

func update_count_text(value):
	$Counter/Number.text = str(round(value)) + "/" + str(maximun_value)