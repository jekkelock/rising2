extends Node

var wood_level = 1
var quarry_level = 0
@export var city_name = "city1"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.register_city(self)


func _on_city_selected(city: Node) -> void:
	pass


func process_turn():
	ResourceManager.day_wood += get_wood_production()
	ResourceManager.day_stone += get_stone_produciton()

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


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	print("e")
	print("event type: ", event)
	if event is InputEventMouseButton:
		print("is mouse button: true")
		print("pressed: ", event.pressed)
		print("button index: ", event.button_index)


func _on_button_pressed() -> void:
	GameManager.select_city(self)
	print("got it")
