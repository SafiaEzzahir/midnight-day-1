extends Node2D

const upanddown = preload("res://Scenes/Letters/HorizontalTrail.tscn")
var h = preload("res://Scenes/Letters/LetterH.tscn")
#preload other scenes

var letterscene = null
var l = []

signal reset

var startpos = null
#connect win/lose signal to trail to change colour

func _ready():
	startpos = $Drawer.position

func _on_letter_h_area_exited(_area: Area2D) -> void:
	_fail_and_reset()

func _fail_and_reset():
	for trail in l:
		remove_child(trail)
	l = []
	$Drawer.position = startpos
	reset.emit()

func _input(_event):
	if Input.is_action_pressed("up"):
		$Drawer.position.y -= 15
		set_up_trail()
	elif Input.is_action_pressed("down"):
		$Drawer.position.y += 15
		set_down_trail()
	elif Input.is_action_pressed("left"):
		$Drawer.position.x -= 15
		set_left_trail()
	elif Input.is_action_pressed("right"):
		$Drawer.position.x += 15
		set_right_trail()
		
func set_up_trail():
	var trail = upanddown.instantiate()
	trail.position.y = $Drawer.position.y + 15
	trail.position.x = $Drawer.position.x
	add_child(trail)
	l.append(trail)

func set_down_trail():
	var trail = upanddown.instantiate()
	trail.position.y = $Drawer.position.y - 15
	trail.position.x = $Drawer.position.x
	add_child(trail)
	l.append(trail)

func set_left_trail():
	var trail = upanddown.instantiate()
	trail.position.y = $Drawer.position.y
	trail.position.x = $Drawer.position.x + 15
	add_child(trail)
	l.append(trail)
	
func set_right_trail():
	var trail = upanddown.instantiate()
	trail.position.y = $Drawer.position.y
	trail.position.x = $Drawer.position.x - 15
	add_child(trail)
	l.append(trail)
