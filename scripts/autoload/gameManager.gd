extends Node

var game_day = 1
var all_cities: Array = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func register_city(city: Node) -> void:
	all_cities.append(city)

func unregister_city(city: Node) -> void:
	all_cities.erase(city)

func end_day() -> void:
	game_day += 1
	for city in all_cities:
		city.process_turn()
	SignalBus.day_ended.emit()


func select_city(city: Node) -> void:
	SignalBus.city_selected.emit(city)
