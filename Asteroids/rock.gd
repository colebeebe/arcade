extends Node2D

var velocity := Vector2.ZERO
@onready var width := get_viewport_rect().size.x
@onready var height := get_viewport_rect().size.y

func _ready() -> void:
	var x = (randf() - 0.5) * 100
	var y = (randf() - 0.5) * 100
	velocity = Vector2(x, y)
	rotate(randf() * 6.28)


func _physics_process(delta: float) -> void:
	update_position(delta)


func update_position(delta: float) -> void:
	position += velocity * delta
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
