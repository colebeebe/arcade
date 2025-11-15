extends Control

@onready var game = get_tree().current_scene
@onready var player = game.get_node("Player")

const VELOCITY_MULTIPLIER := 1.75

func _process(_delta: float) -> void:
	$Score.text = "Score "
	$Time.text = "Time "
	$Fuel.text = "Fuel " + str(int(player.fuel))
	$Altitude.text = "Altitude " + str(768 - int(player.position.y))
	# Here we "fake" some numbers to make them look "dramatic"
	$HorSpeed.text = "Horizontal Speed " + str(int(player.vel.x * VELOCITY_MULTIPLIER))
	$VerSpeed.text = "Vertical Speed " + str(int(player.vel.y * VELOCITY_MULTIPLIER))
