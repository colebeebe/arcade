extends Control

var selection := 1

@onready var asteroid_label = $VBoxContainer/HBoxContainer/Asteroids
@onready var lunar_label = $VBoxContainer/HBoxContainer/LunarLander
@onready var exit_label = $VBoxContainer/Exit

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		selection = 1
		asteroid_label.text = "> Asteroids <"
		lunar_label.text = "Lunar Lander"
		exit_label.text = "Quit"
	elif Input.is_action_just_pressed("right"):
		selection = 2
		asteroid_label.text = "Asteroids"
		lunar_label.text = "> Lunar Lander <"
		exit_label.text = "Quit"
	elif Input.is_action_just_pressed("down"):
		selection = 3
		asteroid_label.text = "Asteroids"
		lunar_label.text = "Lunar Lander"
		exit_label.text = "> Quit <"
	elif Input.is_action_just_pressed("up") && selection == 3:
		selection = 1
		asteroid_label.text = "> Asteroids <"
		lunar_label.text = "Lunar Lander"
		exit_label.text = "Quit"
	
	if Input.is_action_just_pressed("action"):
		match selection:
			1:
				var asteroids = load("res://Asteroids/asteroids.tscn")
				self.queue_free()
				get_tree().current_scene.add_child(asteroids.instantiate())
			2:
				var lunar = load("res://LunarLander/lunar_lander.tscn")
				self.queue_free()
				get_tree().current_scene.add_child(lunar.instantiate())
			3:
				get_tree().quit()
	
	if Input.is_action_just_pressed("escape"):
		get_tree().quit()
