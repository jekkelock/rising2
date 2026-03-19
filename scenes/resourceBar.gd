extends Control

@onready var day_label = $PanelContainer/HBoxContainer/DayLabel
@onready var wood_label = $PanelContainer/HBoxContainer/WoodLabel
@onready var stone_label = $PanelContainer/HBoxContainer/StoneLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update()
	SignalBus.day_ended.connect(_on_day_ended)
	SignalBus.resources_changed.connect(update)



func _on_day_ended() -> void:
	update()
	print("Updated in Resource Bar")

func update() -> void:
	day_label.text = "Day: " + str(GameManager.game_day)
	wood_label.text = str(ResourceManager.get_amount(ResourceManager.ResourceType.WOOD))
	stone_label.text = str(ResourceManager.	get_amount(ResourceManager.ResourceType.STONE))
	

func add_resources_label(resource, amount) -> void:
	var label = Label.new()
	if resource == ResourceManager.ResourceType.WOOD:
		label.position = Vector2(800, 40)
	elif resource == ResourceManager.ResourceType.STONE:
		label.position = Vector2(880, 40)
	label.text = "+" + str(amount)
	label.modulate.a = 0
	label.z_index = -1
	add_child(label)
	var tween = create_tween()
	tween.tween_property(label, "modulate:a", 1.0, 0.5)
	tween.tween_interval(0.5)
	tween.tween_property(label, "position:y", 0, 0.5)
	update()
	tween.tween_callback(func(): label.queue_free())
