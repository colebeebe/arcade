extends Node2D

@onready var screen_dimensions := get_viewport_rect().size

func _ready() -> void:
	var rock_scene = preload("res://Asteroids/Scenes/Rocks/rock.tscn")
	for i in 4:
		var rock = rock_scene.instantiate()
		add_child(rock)
		var x = randf_range(0, screen_dimensions.x)
		var y = randf_range(0, screen_dimensions.y)
		rock.position = Vector2(x, y)
