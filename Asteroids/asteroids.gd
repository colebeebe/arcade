extends Node2D

func _ready() -> void:
	var rock_scene = preload("res://Asteroids/large_rock.tscn")
	for i in 4:
		var rock = rock_scene.instantiate()
		rock.scale = Vector2(2.5, 2.5)
		rock.set_line_weight(0.5)
		add_child(rock)
