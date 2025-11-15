extends Control

var selection := 1

@onready var asteroid_label = $VBoxContainer/HBoxContainer/Asteroids
@onready var lunar_label = $VBoxContainer/HBoxContainer/LunarLander
@onready var exit_label = $VBoxContainer/Exit

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("left"):
		selection = 1
		reset_label_text()
		asteroid_label.text = "> Asteroids <"
	elif Input.is_action_just_pressed("right"):
		selection = 2
		reset_label_text()
		lunar_label.text = "> Lunar Lander <"
	elif Input.is_action_just_pressed("down"):
		selection = 3
		reset_label_text()
		exit_label.text = "> Quit <"
	elif Input.is_action_just_pressed("up") && selection == 3:
		selection = 1
		reset_label_text()
		asteroid_label.text = "> Asteroids <"
	
	if Input.is_action_just_pressed("action") or Input.is_action_just_pressed("special"):
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


func reset_label_text():
	asteroid_label.text = "Asteroids"
	lunar_label.text = "Lunar Lander"
	exit_label.text = "Quit"
