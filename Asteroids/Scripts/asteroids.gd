extends Node2D

func _ready() -> void:
	var rock_scene = preload("res://Asteroids/Scenes/Rocks/rock.tscn")
	for i in 10:
		var rock = rock_scene.instantiate()
		add_child(rock)
	for i in 5:
		var rock2 = rock_scene.instantiate()
		rock2.size = 2
		add_child(rock2)
	for i in 8:
		var rock3 = rock_scene.instantiate()
		rock3.size = 1
		add_child(rock3)
