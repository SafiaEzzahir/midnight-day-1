extends Area2D

var checkpoints = 0
const target = 5

var t1 = false
var t2 = false
var t3 = false
var t4 = false
var t5 = false

func _on_checkpoint_1_area_entered(_area: Area2D) -> void:
	if not t1:
		checkpoints+=1
		t1 = true
		print(checkpoints)
		$Label.text = str(int(checkpoints/target)) + "% done"

func _on_checkpoint_2_area_entered(_area: Area2D) -> void:
	if not t2:
		checkpoints+=1
		t2 = true
		@warning_ignore("integer_division")
		$Label.text = str(int(checkpoints/target)) + "% done"

func _on_checkpoint_3_area_entered(_area: Area2D) -> void:
	if not t3:
		checkpoints+=1
		t3 = true
		@warning_ignore("integer_division")
		$Label.text = str(int(checkpoints/target)) + "% done"

func _on_checkpoint_4_area_entered(_area: Area2D) -> void:
	if not t4:
		checkpoints+=1
		t4 = true
		@warning_ignore("integer_division")
		$Label.text = str(int(checkpoints/target)) + "% done"

func _on_checkpoint_5_area_entered(_area: Area2D) -> void:
	if not t5:
		checkpoints+=1
		t5 = true
		@warning_ignore("integer_division")
		$Label.text = str(int(checkpoints/target)) + "% done"

func _process(_delta: float) -> void:
	if checkpoints == target:
		get_tree().change_scene_to_file("res://Scenes/grade_up.tscn")


func _on_match_shape_scene_reset() -> void:
	checkpoints = 0
