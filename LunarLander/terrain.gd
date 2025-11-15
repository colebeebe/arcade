extends Area2D

func _on_body_entered(body) -> void:
	if body is CharacterBody2D:
		body.is_on_ground = true
		# "Kill" the player
		body.get_node("Graphics").visible = false
