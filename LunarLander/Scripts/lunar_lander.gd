extends Node2D

var score := 0
var time := 0.0

func _process(delta: float) -> void:
	if not $Player.is_on_ground:
		time += delta
