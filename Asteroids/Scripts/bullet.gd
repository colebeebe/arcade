extends Area2D

@export var SPEED := 200.0
@export var LIFE_DURATION := 2.0

var vel := Vector2.ZERO
@onready var width := get_viewport_rect().size.x
@onready var height := get_viewport_rect().size.y
var is_enemy_bullet := false


func _ready() -> void:
	add_to_group("bullets")
	var timer = Timer.new()
	timer.wait_time = LIFE_DURATION
	timer.one_shot = true
	add_child(timer)
	timer.timeout.connect(queue_free)
	timer.start()


func _draw() -> void:
	var rect = Rect2(Vector2(0.0, 0.0), Vector2(3.0, 3.0))
	draw_rect(rect, Color(1.0, 1.0, 1.0, 1.0))


func _physics_process(delta: float) -> void:
	update_position(delta)


func update_position(delta: float) -> void:
	position += vel * SPEED * delta
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
