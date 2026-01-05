extends Area2D

const upanddown = preload("res://Scenes/Letters/HorizontalTrail.tscn")

func _input(_event):
	if Input.is_action_pressed("up"):
		position.y -= 10
		var trail = upanddown.instantiate()
		print(trail)
		trail.position.y = position.y-10
		trail.position.x = position.x
		trail.z_index = 1
	elif Input.is_action_pressed("down"):
		position.y += 10
	elif Input.is_action_pressed("left"):
		position.x -= 10
	elif Input.is_action_pressed("right"):
		position.x += 10
