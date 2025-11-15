extends CharacterBody2D

@export var line_weight: float = 1.0

const ROTATE_SPEED := 50.0
const ACCELERATION := 0.1
const GRAVITY_SPEED := 0.05

var vel := Vector2.ZERO
var is_on_ground := false
var fuel := 1000.0

func _ready() -> void:
	for graphic in $Graphics.get_children():
		graphic.width = line_weight
	rotate(-PI / 2)
	var h_speed = randf_range(25.0, 32.0)
	var v_speed = randf_range(-3.0, 3.0)
	vel = Vector2(h_speed, v_speed)


func _physics_process(delta: float) -> void:
	if not is_on_ground:
		handle_input(delta)
		update_position(delta)


func handle_input(delta: float) -> void:
	# Handle rotation calculations
	if Input.is_action_pressed("left"):
		rotate(deg_to_rad(-ROTATE_SPEED) * delta)
	if Input.is_action_pressed("right"):
		rotate(deg_to_rad(ROTATE_SPEED) * delta)
	
	# Apply thrust
	if Input.is_action_pressed("up") && fuel > 0:
		var forward = Vector2.UP.rotated(rotation)
		vel += forward * ACCELERATION
		fuel -= delta * 16
		if fuel < 0.0: fuel = 0.0


func update_position(delta: float) -> void:
	vel += Vector2(0.0, GRAVITY_SPEED)
	position += vel * delta
