extends Control

func _on_end_day_button_pressed() -> void:
	SignalBus.day_ended.emit()
