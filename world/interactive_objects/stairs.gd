extends Node2D


func _on_ContactZone_body_entered(body):
	body.climb(true)


func _on_ContactZone_body_exited(body):
	body.climb(false)
