extends Node2D

func _on_writing_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/match-shape-scene.tscn")

func _on_maths_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/math_minigame.tscn")

func _on_science_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/sorter_mini_game.tscn")

func _on_murder_button_button_up() -> void:
	get_tree().change_scene_to_file("res://scenes/clock_minigame.tscn")
