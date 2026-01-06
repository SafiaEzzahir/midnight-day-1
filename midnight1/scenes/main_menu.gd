extends Node2D

var time_start = 0
var time_now = 0

func _ready() -> void:
	time_start = Time.get_unix_time_from_system()
	(get_node("/root/Static").notify_names as Signal).connect(notify_names)

func notify_names():
	print("yo!")
	$ItemList.clear()
	for item in (get_node("/root/Static").names as Dictionary).values():
		$ItemList.add_item(item)
	
func _process(delta: float) -> void:
	time_now = Time.get_unix_time_from_system()
	var time_elapsed = time_now - time_start
	connection(time_elapsed)
	
	connected = get_node("/root/Static").is_connected

var connected = false
func connection(time):
	if connected == true:
		if int(time) % 2 == 0:
			$CanvasLayer2/Connected.show()
		else:
			$CanvasLayer2/Connected.hide()
		$CanvasLayer2/Disconnected.hide()
	else:
		if int(time) % 2 == 0:
			$CanvasLayer2/Disconnected.show()
		else:
			$CanvasLayer2/Disconnected.hide()
		$CanvasLayer2/Connected.hide()


func _on_text_edit_text_changed() -> void:
	get_node("/root/Static").send_name($TextEdit.text)


func _on_play_button_button_down() -> void:
	get_tree().change_scene_to_file('res://scenes/MainInterface/HomePage.tscn')
