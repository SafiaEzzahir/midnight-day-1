extends Node2D

@onready var GreenBall1 = $GreenBall1
@onready var GreenBall2 = $GreenBall2
@onready var GreenBall3 = $GreenBall3
@onready var GreenBall4 = $GreenBall4
@onready var OrangeBall1 = $OrangeBall1
@onready var OrangeBall2 = $OrangeBall2
@onready var OrangeBall3 = $OrangeBall3
@onready var OrangeBall4 = $OrangeBall4
@onready var BlueBall1 = $BlueBall1
@onready var BlueBall2 = $BlueBall2
@onready var BlueBall3 = $BlueBall3
@onready var BlueBall4 = $BlueBall4
@onready var Blank1 = $Blank1
@onready var Blank2 = $Blank2
@onready var Blank3 = $Blank3
@onready var Blank4 = $Blank4
@onready var Blank5 = $Blank5
@onready var Blank6 = $Blank6
@onready var Blank7 = $Blank7
@onready var Blank8 = $Blank8

var jar1Place1; var jar1Place2; var jar1Place3; var jar1Place4
var jar2Place1; var jar2Place2; var jar2Place3; var jar2Place4
var jar3Place1; var jar3Place2; var jar3Place3; var jar3Place4
var jar4Place1; var jar4Place2; var jar4Place3; var jar4Place4
var jar5Place1; var jar5Place2; var jar5Place3; var jar5Place4

var jar_balls = {
	1: [],
	2: [],
	3: [],
	4: [],
	5: []
}

var select_next = false
var selected_jar = -1
var has_started = false
var has_won = false

func _ready():

	jar1Place1 = GreenBall1.position
	jar1Place2 = GreenBall2.position
	jar1Place3 = GreenBall3.position
	jar1Place4 = GreenBall4.position

	jar2Place1 = OrangeBall1.position
	jar2Place2 = OrangeBall2.position
	jar2Place3 = OrangeBall3.position
	jar2Place4 = OrangeBall4.position

	jar3Place1 = BlueBall1.position
	jar3Place2 = BlueBall2.position
	jar3Place3 = BlueBall3.position
	jar3Place4 = BlueBall4.position

	jar4Place1 = Blank1.position
	jar4Place2 = Blank2.position
	jar4Place3 = Blank3.position
	jar4Place4 = Blank4.position

	jar5Place1 = Blank5.position
	jar5Place2 = Blank6.position
	jar5Place3 = Blank7.position
	jar5Place4 = Blank8.position

	start()

func start():
	var coloursList = ["green", "blue", "orange"]
	var colour = coloursList[randi() % coloursList.size()]

	match colour:
		"green":
			jar_balls[1] = [GreenBall1, GreenBall2, OrangeBall1, OrangeBall2]
			jar_balls[2] = [OrangeBall3, BlueBall1, BlueBall2, GreenBall3]
			jar_balls[3] = [BlueBall3, BlueBall4, GreenBall4, OrangeBall4]
		"blue":
			jar_balls[1] = [BlueBall1, BlueBall2, GreenBall1, GreenBall2]
			jar_balls[2] = [GreenBall3, OrangeBall1, OrangeBall2, BlueBall3]
			jar_balls[3] = [OrangeBall3, OrangeBall4, BlueBall4, GreenBall4]
		"orange":
			jar_balls[1] = [OrangeBall1, OrangeBall2, BlueBall1, BlueBall2]
			jar_balls[2] = [BlueBall3, GreenBall1, OrangeBall3, GreenBall2]
			jar_balls[3] = [GreenBall3, OrangeBall4, GreenBall4, BlueBall4]

	jar_balls[4] = []
	jar_balls[5] = []

	for jar in jar_balls.keys():
		for i in range(jar_balls[jar].size()):
			jar_balls[jar][i].position = get_jar_position(jar, i + 1)

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if not has_started:
			has_started = true  

		var jar = get_clicked_jar(event.global_position.x)
		if jar == -1:
			return

		if not select_next:
			selected_jar = jar
			select_next = true
		else:
			move_ball(selected_jar, jar)
			select_next = false

func move_ball(from_jar, to_jar):
	if jar_balls[from_jar].is_empty():
		return
	if jar_balls[to_jar].size() >= 4:
		return

	var ball = jar_balls[from_jar].pop_back()
	jar_balls[to_jar].append(ball)

	ball.position = get_jar_position(to_jar, jar_balls[to_jar].size())

	check_success()

func get_jar_position(jar, height):
	match jar:
		1: return [jar1Place1, jar1Place2, jar1Place3, jar1Place4][height - 1]
		2: return [jar2Place1, jar2Place2, jar2Place3, jar2Place4][height - 1]
		3: return [jar3Place1, jar3Place2, jar3Place3, jar3Place4][height - 1]
		4: return [jar4Place1, jar4Place2, jar4Place3, jar4Place4][height - 1]
		5: return [jar5Place1, jar5Place2, jar5Place3, jar5Place4][height - 1]
	return Vector2.ZERO

func get_clicked_jar(mouse_x):
	if mouse_x >= 80 and mouse_x <= 157:
		return 1
	elif mouse_x >= 304 and mouse_x <= 379:
		return 2
	elif mouse_x >= 529 and mouse_x <= 606:
		return 3
	elif mouse_x >= 754 and mouse_x <= 829:
		return 4
	elif mouse_x >= 978 and mouse_x <= 1054:
		return 5
	return -1

func check_success():
	if not has_started or has_won:
		return false

	for jar in jar_balls.keys():
		if jar_balls[jar].is_empty():
			continue 

		if jar_balls[jar].size() != 4:
			return false

		var first_colour = jar_balls[jar][0].name.substr(
			0, jar_balls[jar][0].name.find("Ball")
		)

		for ball in jar_balls[jar]:
			var colour = ball.name.substr(0, ball.name.find("Ball"))
			if colour != first_colour:
				return false

	print("Success!")
	$WinLogo.show()
	has_won = true
	return true
