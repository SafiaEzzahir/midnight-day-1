extends Node2D

var h = preload("res://Scenes/Letters/LetterH.tscn")
#preload other scenes

var letterscene = null

#instantiate current letter scene

func _ready():
	pass

func _on_letter_h_area_exited(area: Area2D) -> void:
	_fail_and_reset()

func _fail_and_reset():
	$TextureRect.texture = load("res://Assets/BadlogoMJ.png")
