extends Node

var wood_level = 1
var quarry_level = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.day_ended.connect(_on_day_ended)


func _on_day_ended() -> void:
	ResourceManager.day_wood += get_wood_production()
	print("city.gd sent wood production")

func get_wood_production() -> int:
	match wood_level:
		0: return 0
		1: return 50
		2: return 100
		_: return 0

func get_stone_produciton() -> int:
	match quarry_level:
		0: return 0
		1: return 20
		2: return 40
		_: return 0
