extends Node2D


func _ready() -> void:
	var names = get_node("/root/Static").names as Dictionary
	
	for uuid in names:
		if uuid == get_node("/root/Static").user_id:
			continue
		var arrow = load("res://scenes/arrow.tscn").instantiate()
		$Targets.add_child(arrow)
		arrow.global_position.x = randi_range(0 + 40, 1152 - 40)
		arrow.global_position.y = randi_range(0 + 40, 648 - 40)
		arrow.get_child(0).text = names[uuid]
		arrow.uuid = uuid
		
var size = 400

func _process(delta: float) -> void:
	if(Input.is_action_pressed("down")):
		$Arrow.position.y += delta * size
	if(Input.is_action_pressed("up")):
		$Arrow.position.y -= delta * size
	if(Input.is_action_pressed("left")):
		$Arrow.position.x -= delta * size
	if(Input.is_action_pressed("right")):
		$Arrow.position.x += delta * size
		
	if(Input.is_action_pressed("enter") && target != null):
		get_node("/root/Static").send_kill(target.get_parent().uuid)
		target.get_parent().queue_free()
	
var target = null
