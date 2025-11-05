extends Node2D

const ROTATE_SPEED := 180.0

func _physics_process(delta: float) -> void:
	handle_input(delta)

func handle_input(delta: float) -> void:
	# Handle rotation calculations
	if Input.is_action_pressed("left"):
		rotate(deg_to_rad(-ROTATE_SPEED) * delta)
	if Input.is_action_pressed("right"):
		rotate(deg_to_rad(ROTATE_SPEED) * delta)
	
	# Apply thruster
	if Input.is_action_pressed("up"):
		pass
