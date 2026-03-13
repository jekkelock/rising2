extends Node

var lumber_level = 1
var quarry_level = 0
@export var city_name = "city1"

var building_info: Dictionary = {
	"lumber_yard": {
		"name": "Lumber Yard",
		"description": "Produces wood every day",
		"level": 1,
		"max_level": 3
	},
	"quarry": {
		"name": "Quarry",
		"description": "Produces stone every day",
		"level": 1,
		"max_level": 3
	}
}


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.register_city(self)

func process_turn():
	ResourceManager.day_wood += get_wood_production()
	ResourceManager.day_stone += get_stone_produciton()

func get_wood_production() -> int:
	match lumber_level:
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
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		GameManager.select_city(self)
