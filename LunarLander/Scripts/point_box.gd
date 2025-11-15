extends Area2D

@export var point_multiplier := 2

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.is_on_ground = true
		body.kill_animation()
		var root = get_tree().current_scene.get_node("LunarLander")
		var message_box = root.get_node("CanvasLayer").get_node("Message")
		if abs(body.vel.y * 1.95) > 16 && abs(body.vel.x * 1.95) > 3:
			body.get_node("Graphics").visible = false
			message_box.text = "That was a pretty rough landing!\nYour vessel was destroyed!"
			var fuel_loss = randi_range(100, 250)
			message_box.text += "\n\n%d units of fuel lost!" % [fuel_loss]
			root.get_node("Player").fuel -= fuel_loss
		else:
			var rating = body.fuel * 5 * point_multiplier
			root.score += rating
			message_box.text = "A beautiful landing!\n\nRating: %d" % [rating]
		root.reset_game()
			
