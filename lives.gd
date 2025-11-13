extends Control

@export var num_lives := 0
@onready var ship_graphic := preload("res://Asteroids/Scenes/Player/ship.tscn")

func update_lives() -> void:
	for child in get_children():
		child.queue_free()
	
	for i in num_lives:
		var control = Control.new()
		var ship = ship_graphic.instantiate()
		ship.scale = Vector2(1.65, 1.65)
		control.custom_minimum_size = Vector2(12, 0.0)
		control.add_child(ship)
		ship.position = Vector2(6.0, 0.0)
		add_child(control)
