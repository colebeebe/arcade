extends Area2D

@export var point_multiplier := 2

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.is_on_ground = true
		body.collision_layer = 0
		body.collision_mask = 0
		body.kill_animation()
		if abs(body.vel.y * 1.95) > 16 && abs(body.vel.x * 1.95) > 3:
			body.get_node("Graphics").visible = false
		else:
			var root = get_tree().current_scene
			root.score += (body.fuel * 5) * point_multiplier
			
