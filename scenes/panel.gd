extends Control

const panel_width = 300
var is_open: bool = false
var current_city = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel.position.x = -panel_width
	SignalBus.city_selected.connect(_on_city_selected)

func _on_city_selected(city: Node) -> void:
	if is_open == true and current_city == city:
		close()
	else:
		open(city)

func open(city) -> void:
	current_city = city
	is_open = true
	var tween = create_tween()
	tween.tween_property($Panel, "position:x", 70 ,0.3)
	tween.tween_property($Panel, "position:x", 50 ,0.2)

func close() -> void:
	is_open = false
	current_city = null
	var tween = create_tween()
	tween.tween_property($Panel, "position:x", 70, 0.2)
	tween.tween_property($Panel, "position:x", -panel_width, 0.2)

func _populate() -> void:
	if current_city == null:
		return
	else:
		$Panel/VBoxContainer/CityNameLabel.text = current_city.city_name
		$Panel/VBoxContainer/MarginContainer/GridContainer/PanelContainer/HBoxContainer/Building1Label.text = "Lumber Yard"
