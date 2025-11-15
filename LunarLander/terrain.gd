extends Area2D

func _on_body_entered(body) -> void:
	if body is CharacterBody2D:
		body.is_on_ground = true
		# "Kill" the player
		body.get_node("Graphics").visible = false
		var root = get_tree().current_scene.get_node("LunarLander")
		var message_box = root.get_node("CanvasLayer").get_node("Message")
		message_box.text = "You caused irreparable damage to a\nmultimillion dollar piece of equipment."
		if body.fuel > 0:
			var fuel_loss = randi_range(100, 250)
			if fuel_loss > body.fuel:
				fuel_loss = body.fuel
			message_box.text += "\n\n%d units of fuel lost." % [fuel_loss]
			body.fuel -= fuel_loss
			if body.fuel == 0:
				message_box.text += "\n\nYou are out of fuel.\n\nGAME OVER"
			else:
				root.reset_game()
		else: 
			message_box.text += "\n\nYou are out of fuel.\n\nGAME OVER"
