extends Node2D

func _ready() -> void:
	for item in (get_node("/root/Static").names as Dictionary).values():
		$ItemList.add_item(str(item) + ": " + get_node('/root/Static').grade())
