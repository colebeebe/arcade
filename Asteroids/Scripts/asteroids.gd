extends Node2D

@onready var screen_dimensions := get_viewport_rect().size
@onready var rock_scene = preload("res://Asteroids/Scenes/Rocks/rock.tscn")
var level := 1
var lives := 3
var score := 0
var next_life := 10000

func _ready() -> void:
	spawn_rocks()
	$Score.position = screen_dimensions / -2
	$Score.position.x += 20
	$Score.position.y += 40
	$Lives.position = screen_dimensions / -2
	$Lives.position.x += 20
	$Lives.position.y += 80
	update_life_hud()


func _process(_delta: float) -> void:
	if get_tree().get_nodes_in_group("rocks").is_empty():
		level += 1
		spawn_rocks()
	if Input.is_action_just_pressed("escape"):
		var menu = load("res://MainMenu/MainMenu.tscn")
		get_tree().current_scene.add_child(menu.instantiate())
		self.queue_free()
		

func spawn_rocks() -> void:
	# Add rocks to the scene at a random position
	for i in (3 + level):
		var rock = rock_scene.instantiate()
		add_child(rock)
		var x = randf_range(0, screen_dimensions.x)
		var y = randf_range(0, screen_dimensions.y)
		rock.position = Vector2(x, y)


func update_life_hud() -> void:
	$Lives.num_lives = lives
	$Lives.update_lives()
	if lives == 0:
		var go_message = Label.new()
		add_child(go_message)
		go_message.text = "Game Over"


func update_score() -> void:
	$Score.text = str(score)
	if score >= next_life:
		next_life += 10000
		lives += 1
		update_life_hud()
	if score == 0:
		$GameOver.visible = true
