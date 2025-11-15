extends CharacterBody2D

@export var line_weight: float = 1.0

const ROTATE_SPEED := 50.0
const ACCELERATION := 0.3

var vel := Vector2(30.0, 0.0)
var is_on_ground := false

func _ready() -> void:
	for graphic in $Graphics.get_children():
		graphic.width = line_weight
	rotate(-PI / 2)


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
	if Input.is_action_pressed("up"):
		var forward = Vector2.UP.rotated(rotation)
		vel += forward * ACCELERATION


func update_position(delta: float) -> void:
	vel += Vector2(0.0, 0.18)
	position += vel * delta
