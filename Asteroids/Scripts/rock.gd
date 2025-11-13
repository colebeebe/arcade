extends Area2D

var size := 3
var vel := Vector2.ZERO
@onready var width := get_viewport_rect().size.x
@onready var height := get_viewport_rect().size.y


func _ready() -> void:
	var grace_timer = Timer.new()
	add_child(grace_timer)
	grace_timer.one_shot = true
	grace_timer.wait_time = 0.5
	grace_timer.timeout.connect(func(): 
		$CollisionShape2D.disabled = false
		grace_timer.queue_free()
		)
	grace_timer.start()
	add_to_group("rocks")
	# Choose which graphic to display
	var graphic = create_graphic_node()
	add_child(graphic)
	# Set up the rock based on size
	var velocity_multiplier := 0.0
	match size:
		3: 
			scale = Vector2(2.5, 2.5)
			set_line_weight(0.5)
			velocity_multiplier = 100.0
		2:
			scale = Vector2(1.5, 1.5)
			set_line_weight(0.65)
			velocity_multiplier = 150.0
		1:
			scale = Vector2(0.8, 0.8)
			set_line_weight(1.2)
			velocity_multiplier = 200.0
	# Create a random velocity
	var x = (randf() - 0.5) * velocity_multiplier
	var y = (randf() - 0.5) * velocity_multiplier
	vel = Vector2(x, y)
	# Rotate the rock randomly. Here, randf() gives us a random float between
	# 0.0 and 1.0, and rotate() expects radians, so we multiply the random
	# number by 2 * PI so it can be any rotation
	rotate(randf() * 6.28)
	# Set up collision handling
	connect("body_entered", on_body_entered)
	connect("area_entered", on_area_entered)


func _physics_process(delta: float) -> void:
	update_position(delta)


func update_position(delta: float) -> void:
	position += vel * delta
	# x-axis wrapping
	if position.x > width / 2:
		position.x = (-width / 2) + 1
	if position.x < -width / 2:
		position.x = (width / 2) - 1
	# y-axis wrapping
	if position.y > height / 2:
		position.y = (-height / 2) + 1
	if position.y < -height / 2:
		position.y = (height / 2) - 1
	


func set_line_weight(weight: float) -> void:
	$Graphic.width = weight


func create_graphic_node() -> Node:
	var variant = randi_range(1, 4)
	var graphic_path = "res://Asteroids/Scenes/Rocks/graphic" + str(variant) + ".tscn"
	var graphic_scene = load(graphic_path)
	var graphic = graphic_scene.instantiate()
	graphic.name = "Graphic"
	return graphic


func break_apart() -> void:
	# If the rock is the smallest size, go ahead and delete it
	if size == 1:
		queue_free()
	else:
		# Add two rocks that are one size smaller and destroy the original
		var rock_scene = preload("res://Asteroids/Scenes/Rocks/rock.tscn")
		for i in 2:
			var rock = rock_scene.instantiate()
			rock.size = size - 1
			get_tree().current_scene.add_child(rock)
			rock.position = position
		queue_free()


func on_body_entered(body: Node) -> void:
	# If the player has collided with a rock, kill the player and break the rock
	if body.name == "Player":
		get_parent().lives -= 1
		get_parent().update_life_hud()
		if get_parent().lives == 0:
			body.queue_free()
		else:
			body.reset()
			
		call_deferred("break_apart")


func on_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullets"):
		area.queue_free()
		call_deferred("break_apart")
