extends Node2D

signal mathsclicked
signal writingclicked
signal scienceclicked
signal otherclicked

func _on_writing_button_button_up() -> void:
	writingclicked.emit()



func _on_maths_button_button_up() -> void:
	mathsclicked.emit()


func _on_science_button_button_up() -> void:
	scienceclicked.emit()


func _on_murder_button_button_up() -> void:
	otherclicked.emit()
