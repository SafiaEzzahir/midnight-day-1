extends Node2D

var total_time = 0
var correct_time = 0
var correct = false

func _ready() -> void:
	correct_time = randf_range(0, 60*12)
	
	var minute_hand = roundi(correct_time) % 60
	var hour_hand = correct_time / 60
	
	$Label.text = "%d:%02d" % [hour_hand, minute_hand]

func _process(delta: float) -> void:
	#total_time += delta * 100
	update_clock(total_time)
	print("%f : %f", total_time, correct_time)

var last_pos = Vector2.ZERO
func _input(event: InputEvent) -> void:
	if(event is InputEventMouse):
		if(event.button_mask == MOUSE_BUTTON_LEFT && !correct):
			total_time += event.position.x - last_pos.x
		last_pos = event.position
	if(Input.is_action_just_released("mouse_down")):
		if(correct_time - 2 < total_time && total_time < correct_time + 2):
			correct = true
			$Label2/Timer.start()
			$Label2.show()

func update_clock(time: float):
	var minute_hand = roundi(time) % 60
	var hour_hand = time / 60
	
	$BigHandPivot.rotation_degrees = (minute_hand as float / 60) * 360
	$LittleHandPivot.rotation_degrees = (hour_hand / 12) * 360
	

var white_or_black = false
func _on_timer_timeout() -> void:
	var col = Color.BLACK
	if(white_or_black):
		col = Color.WHITE
	white_or_black = !white_or_black
	$Label2.add_theme_color_override("font_color", col)
