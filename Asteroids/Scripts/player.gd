extends CharacterBody2D

const ROTATE_SPEED := 180.0
const ACCELERATION := 15.0

var vel := Vector2.ZERO
@onready var width := get_viewport_rect().size.x
@onready var height := get_viewport_rect().size.y

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
		$AnimationPlayer.play("flame_flicker")
		var forward = Vector2.UP.rotated(rotation)
		vel += forward * ACCELERATION 
	else:
		$AnimationPlayer.stop()
		$Flame.visible = false


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
