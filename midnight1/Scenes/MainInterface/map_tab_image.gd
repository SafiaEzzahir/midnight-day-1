extends TextureRect

var offtexture = preload("res://Assets/endinactivetab.png")
var ontexture = preload("res://Assets/endactivetab.png")

func _on_home_page_change_map_img(on):
	if on:
		texture = ontexture
	else:
		texture = offtexture
