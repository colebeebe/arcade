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

func reset_game() -> void:
	var timer = Timer.new()
	add_child(timer)
	timer.wait_time = 5.0
	timer.one_shot = true
	timer.connect("timeout", func():
		$Player.position = Vector2(68.0, 126.0)
		var vx = randf_range(25.0, 32.0)
		var vy = randf_range(-10.0, 3.0)
		$Player.vel = Vector2(vx, vy)
		$Player.get_node("Graphics").visible = true
		$Player.is_on_ground = false
		$CanvasLayer/Message.text = ""
		$Player.rotation = -PI / 2
		)
	timer.start()
