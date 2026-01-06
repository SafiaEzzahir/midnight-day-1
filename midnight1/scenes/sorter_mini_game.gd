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

var jar1Place1
var jar1Place2
var jar1Place3
var jar1Place4
var jar2Place1
var jar2Place2
var jar2Place3
var jar2Place4
var jar3Place1
var jar3Place2
var jar3Place3
var jar3Place4
var jar4Place1
var jar4Place2
var jar4Place3
var jar4Place4
var jar5Place1
var jar5Place2
var jar5Place3
var jar5Place4

func _ready() -> void:
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
	
	if colour == "green":
		
		$GreenBall1.position = jar1Place1
		$GreenBall2.position = jar1Place3
		$GreenBall3.position = jar2Place4
		$GreenBall4.position = jar3Place2
		
		$OrangeBall1.position = jar1Place2
		$OrangeBall2.position = jar1Place4
		$OrangeBall3.position = jar2Place1
		$OrangeBall4.position = jar2Place2
		
		$BlueBall1.position = jar2Place3
		$BlueBall2.position = jar3Place1
		$BlueBall3.position = jar3Place3
		$BlueBall4.position = jar3Place4
		
	elif colour == "blue":
		
		$BlueBall1.position = jar1Place1
		$BlueBall2.position = jar1Place3
		$BlueBall3.position = jar2Place4
		$BlueBall4.position = jar3Place2
		
		$GreenBall1.position = jar1Place2
		$GreenBall2.position = jar1Place4
		$GreenBall3.position = jar2Place1
		$GreenBall4.position = jar2Place2
		
		$OrangeBall1.position = jar2Place3
		$OrangeBall2.position = jar3Place1
		$OrangeBall3.position = jar3Place3
		$OrangeBall4.position = jar3Place4
		
	else:
		
		$OrangeBall1.position = jar1Place1
		$OrangeBall2.position = jar1Place3
		$OrangeBall3.position = jar2Place4
		$OrangeBall4.position = jar3Place2
		
		$BlueBall1.position = jar1Place2
		$BlueBall2.position = jar1Place4
		$BlueBall3.position = jar2Place1
		$BlueBall4.position = jar2Place2
		
		$GreenBall1.position = jar2Place3
		$GreenBall2.position = jar3Place1
		$GreenBall3.position = jar3Place3
		$GreenBall4.position = jar3Place4
