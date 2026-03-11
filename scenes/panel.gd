extends Control

const panel_width = 300

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Panel.position.x = -panel_width
