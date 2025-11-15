extends Node2D

var score := 0
var time := 0.0

func _process(delta: float) -> void:
	if not $Player.is_on_ground:
		time += delta
	if Input.is_action_just_pressed("escape"):
		var menu = load("res://MainMenu/MainMenu.tscn")
		get_tree().current_scene.add_child(menu.instantiate())
		self.queue_free()
