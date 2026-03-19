extends Control

const panel_width = 300
var is_open: bool = false
var current_city = null
var is_info_open: bool = false
var current_info: String = ""       #Stores current building info

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel.position.x = -panel_width
	$InfoPanel.visible = false
	SignalBus.city_selected.connect(_on_city_selected)
	#WHAT BUILDING INFORMATION TO DFISPLAY
	$Panel/VBoxContainer/MarginContainer/GridContainer/Building1.gui_input.connect(_on_building_clicked.bind("lumber_yard"))
	$Panel/VBoxContainer/MarginContainer/GridContainer/Building2/HBoxContainer.gui_input.connect(_on_building_clicked.bind("quarry"))
func _on_building_clicked(event: InputEvent, building_name: String) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		building_panel(building_name)
		current_info = building_name
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
	_populate()
func close() -> void:
	is_open = false
	current_city = null
	$InfoPanel.visible = false
	current_info = ""
	var tween = create_tween()
	tween.tween_property($Panel, "position:x", 70, 0.2)
	tween.tween_property($Panel, "position:x", -panel_width, 0.2)
func _populate() -> void:
	if current_city == null:
		return
	else:
		$Panel/VBoxContainer/CityNameLabel.text = current_city.city_name
		$Panel/VBoxContainer/MarginContainer/GridContainer/Building1/HBoxContainer/VBoxContainer/Building1Label.text = "Lumber Yard"
		$Panel/VBoxContainer/MarginContainer/GridContainer/Building1/HBoxContainer/VBoxContainer/Buidling1Level.text = "LvL: " + str(current_city.building_info["lumber_yard"]["level"])
func building_panel(building_name: String) -> void:
	open_info()
	is_info_open = true
	var info = current_city.building_info[building_name]
	$InfoPanel/VBoxContainer/BuildingNameLabel.text = info["name"]
	$InfoPanel/VBoxContainer/LevelLabel.text = "LEVEL:" + str(info["level"])
	$InfoPanel/VBoxContainer/DescriptionLabel.text = info["description"]
	$InfoPanel/VBoxContainer/StatsLabel.text = "Produces:" + str(info["level"] * 50)
	$InfoPanel/VBoxContainer/UpgradeButton.text = str(info["level"] * 100)



func open_info() -> void:
	if is_info_open == true:
		#var tween1 = create_tween()
		#tween1.tween_property($InfoPanel, "modulate:a", 0, 0.3)
		#tween1.tween_callback(func(): is_info_open = false)
		return
	else:
		$InfoPanel.visible = true
		is_info_open = true
	var tween = create_tween()
	tween.tween_property($InfoPanel, "modulate:a", 1, 0.2)
func update_info():
	var info = current_city.building_info[current_info]
	$InfoPanel/VBoxContainer/BuildingNameLabel.text = info["name"]
	$InfoPanel/VBoxContainer/LevelLabel.text = "LEVEL:" + str(info["level"])
	$InfoPanel/VBoxContainer/DescriptionLabel.text = info["description"]
	$InfoPanel/VBoxContainer/StatsLabel.text = "Produces:" + str(info["level"] * 50)
	if info["level"] < info["max_level"]:
		$InfoPanel/VBoxContainer/UpgradeButton.text = str(info["level"] * 100)
	else: $InfoPanel/VBoxContainer/UpgradeButton.text = "Max Level"
 
func close_info() -> void:
	if is_info_open == false:
		return
	else:
		is_info_open = false
	var tween = create_tween()
	tween.tween_property($InfoPanel, "modulate:a", 0, 0.3)
	tween.tween_callback(func(): $InfoPanel.visible = false)

func _on_close_button_pressed() -> void:	
	close()


func _on_info_close_button_pressed() -> void:
	close_info()

func get_upgrade_cost() -> Dictionary:
	var current_level: int
	var upgrade_cost: Dictionary
	if current_city.building_info[current_info]["level"] < current_city.building_info[current_info]["max_level"]:
		current_level = current_city.building_info[current_info]["level"]
		upgrade_cost = current_city.building_upgrade_cost[current_info][current_level]
	else: 
		print("max level")
		upgrade_cost = {}
	return upgrade_cost

func _on_upgrade_button_pressed() -> void:
	var cost = get_upgrade_cost()
	if cost == {}:
		return
	elif ResourceManager.spend(cost):
		current_city.building_info["lumber_yard"]["level"] += 1
		update_info()
	else:
		print("no materials")
	
	
	
	
	#var info = current_city.building_info[current_info]
	#if info["level"] >= info["max_level"]:
		#print("already max level")
		#return
	#var cost: int = check_upgrade_cost()
	#if ResourceManager.spend({ResourceManager.ResourceType.WOOD: cost}):
		#info["level"] += 1
		#building_panel(current_info)
		
