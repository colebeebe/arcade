extends Area2D

@export var point_multiplier := 2

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.is_on_ground = true
