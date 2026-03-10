extends Node

var game_day = 1


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.day_ended.connect(_on_day_ended)


func _on_day_ended() -> void:
	game_day += 1
	print("Game Manager Day ended")
