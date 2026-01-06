extends Sprite2D


signal has_target
var uuid = 0

func _on_area_2d_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	get_node("/root/Murderer/Arrow/MurderShow").show()
	get_node("/root/Murderer").target = self
	
	

func _on_area_2d_body_shape_exited(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	get_node("/root/Murderer/Arrow/MurderShow").hide()
