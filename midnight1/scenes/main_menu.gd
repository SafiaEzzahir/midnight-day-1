extends Node2D

var time_start = 0
var time_now = 0

func _ready() -> void:
	time_start = Time.get_unix_time_from_system()
	
func _process(delta: float) -> void:
	time_now = Time.get_unix_time_from_system()
	var time_elapsed = time_now - time_start
	connection(time_elapsed)

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
