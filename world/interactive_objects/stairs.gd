extends Node2D


func _on_ContactZone_body_entered(body):
	body.climb(true)
	print("stair entered")


func _on_ContactZone_body_exited(body):
	body.climb(false)
	print("stair exit")
