extends Node

enum ResourceType {WOOD, STONE, IRON, FOOD, GOLD, RAW_IRON}

var amounts: Dictionary = {
	ResourceType.WOOD: 100,
	ResourceType.STONE: 0
}

var day_wood: int = 0
var day_stone: int = 0

func _ready() -> void:
	SignalBus.day_ended.connect(_on_day_ended)
#holds the amount the cities produce in order to be added at the end of the day to the total sum
func _on_day_ended() -> void:
	amounts[ResourceType.WOOD] += day_wood
	amounts[ResourceType.STONE] += day_stone
	print(day_wood)
	day_wood = 0
	day_stone = 0
	print(amounts[ResourceType.WOOD])

func spend(cost: Dictionary) -> bool:
	if not can_afford(cost):
		#SignalBus.notification.emit("Not enough resources!", 2.0)
		return false
	for resource in cost:
		amounts[resource] -= cost[resource]
	#SignalBus.resources_changed.emit()
	return true

func add_gains(gains: Dictionary) -> void:
	for resource in gains:
		amounts[resource] += gains[resource]
	#SignalBus.resources_changed.emit()

func can_afford(cost: Dictionary) -> bool:
	for resource in cost:
		if amounts[resource] < cost[resource]:
			return false
	return true

func get_amount(resource: ResourceType) -> int:
	return amounts[resource]
