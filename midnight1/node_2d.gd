extends Node2D

func _ready() -> void:
	$ItemList.clear()
	for item in (get_node("/root/Static").names as Dictionary).values():
		$ItemList.add_item(item)

func _process(delta: float) -> void:
	pass

func _on_item_list_item_selected(index):
	get_node("/root/Static").vote(get_node("/root/Static").names.keys()[index])
	print("Item selected")
	$VotedLogo.show()
	$CanvasLayer/Title.hide()
	$ItemList.hide()
