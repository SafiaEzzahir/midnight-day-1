extends Node2D

func _ready() -> void:
	for item in (get_node("/root/Static").names as Dictionary).keys():
		$ItemList.add_item(str(get_node("/root/Static").names[item]) + ": " + get_node('/root/Static').grade(item))
