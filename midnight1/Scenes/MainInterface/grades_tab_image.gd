extends TextureRect

var offtexture = preload("res://Assets/inactivetab.png")
var ontexture = preload("res://Assets/opentaskstab.png")

func _on_home_page_change_grades_img(on):
	if on:
		texture = ontexture
	else:
		texture = offtexture
