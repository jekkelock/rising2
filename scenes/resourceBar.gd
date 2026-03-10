extends Control

@onready var day_label = $PanelContainer/HBoxContainer/DayLabel
@onready var wood_label = $PanelContainer/HBoxContainer/WoodLabel
@onready var stone_label = $PanelContainer/HBoxContainer/StoneLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	SignalBus.day_ended.connect(_on_day_ended)



func _on_day_ended() -> void:
	update()
	print("Updated in Resource Bar")

func update() -> void:
	day_label.text = "Day: " + str(GameManager.game_day)
	wood_label.text = str(ResourceManager.get_amount(ResourceManager.ResourceType.WOOD))
	stone_label.text = str(ResourceManager.get_amount(ResourceManager.ResourceType.STONE))
	
	
