extends Node2D


func _ready() -> void:
	(get_node("/root/Static").notify_names as Signal).connect(notify_names)

func notify_names():
	print("yo!")
	$ItemList.clear()
	for item in (get_node("/root/Static").names as Dictionary).values():
		$ItemList.add_item(item)

func _process(delta: float) -> void:
	pass
