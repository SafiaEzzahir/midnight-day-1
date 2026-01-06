extends Node2D

func _ready() -> void:
	get_node("/root/Static").current_grade += 1
	var current_grade = get_node("/root/Static").grade_progress[get_node("/root/Static").current_grade]
	var old_grade = get_node("/root/Static").grade_progress[get_node("/root/Static").current_grade - 1]
	
	var grade_prog = "Grade up!\n%s -> %s" % [old_grade, current_grade]
	$Homework.text =  grade_prog
	
	await get_tree().create_timer(3).timeout
	get_tree().change_scene_to_file("res://Scenes/MainInterface/HomePage.tscn")
