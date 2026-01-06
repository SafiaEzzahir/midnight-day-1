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
		
var size = 40

func _process(delta: float) -> void:
	if(Input.is_action_pressed("down")):
		if $Arrow.position.y <= 648:
			$Arrow.position.y += delta * size
		else:
			$Arrow.position.y = 648
	if(Input.is_action_pressed("up")):
		if $Arrow.position.y >= 0:
			$Arrow.position.y -= delta * size
		else:
			$Arrow.position.y = 0
	if(Input.is_action_pressed("left")):
		if $Arrow.position.x >= 0:
			$Arrow.position.x -= delta * size
		else:
			$Arrow.position.x = 0
	if(Input.is_action_pressed("right")):
		if $Arrow.position.x <= 1152:
			$Arrow.position.x += delta * size
		else:
			$Arrow.position.x = 1152
		
	if(Input.is_action_pressed("enter") && target != null):
		get_node("/root/Static").send_kill(target.uuid)
		target.queue_free()
	
var target = null
