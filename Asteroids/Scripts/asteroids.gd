extends Node2D

@onready var screen_dimensions := get_viewport_rect().size
@onready var rock_scene = preload("res://Asteroids/Scenes/Rocks/rock.tscn")
var level := 1

func _ready() -> void:
	spawn_rocks()


func _process(_delta: float) -> void:
	if get_tree().get_nodes_in_group("rocks").is_empty():
		level += 1
		spawn_rocks()

func spawn_rocks() -> void:
	# Add rocks to the scene at a random position
	for i in (3 + level):
		var rock = rock_scene.instantiate()
		add_child(rock)
		var x = randf_range(0, screen_dimensions.x)
		var y = randf_range(0, screen_dimensions.y)
		rock.position = Vector2(x, y)
