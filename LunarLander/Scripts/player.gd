extends CharacterBody2D

@export var line_weight: float = 1.0

const ROTATE_SPEED := 180.0
const ACCELERATION := 15.0

var vel := Vector2.ZERO

func _ready() -> void:
	for graphic in $Graphics.get_children():
		graphic.width = line_weight


func _physics_process(delta: float) -> void:
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
	position += vel * delta
