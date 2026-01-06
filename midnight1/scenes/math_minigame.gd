extends Node2D

@onready var PlusNum1 = $PlusNum1
@onready var PlusNum2 = $PlusNum2
@onready var MinusNum1 = $MinusNum1
@onready var MinusNum2 = $MinusNum2
@onready var TimesNum1 = $TimesNum1
@onready var TimesNum2 = $TimesNum2
@onready var DivideNum1 = $DivideNum1
@onready var DivideNum2 = $DivideNum2
@onready var PlusInput = $PlusInput
@onready var MinusInput = $MinusInput
@onready var TimesInput = $TimesInput
@onready var DivideInput = $DivideInput

var plus_correct = false
var minus_correct = false
var times_correct = false
var divide_correct = false

func _ready() -> void:
	questions() 
	_on_times_input_text_changed()
	_on_minus_input_text_changed()
	_on_divide_input_text_changed()
	_on_plus_input_text_changed()

func questions():
	PlusNum1.text = str(randi_range(1,9))
	PlusNum2.text = str(randi_range(1,9))
	MinusNum1.text = str(randi_range(1,9))
	MinusNum2.text = str(randi_range(1,9))
	while int(MinusNum1.text) == int(MinusNum2.text):
		MinusNum1.text = str(randi_range(1,9))
	TimesNum1.text = str(randi_range(1,9))
	TimesNum2.text = str(randi_range(1,9))
	DivideNum1.text = str(randi_range(1,144))
	DivideNum2.text = str(randi_range(2,12))
	while int(DivideNum1.text) % int(DivideNum2.text) != 0:
		DivideNum2.text =str(randi_range(2,12))

func _process(delta: float) -> void:
	if times_correct && divide_correct && plus_correct &&minus_correct:
		get_tree().change_scene_to_file("res://scenes/grade_up.tscn")

func _on_times_input_text_changed() -> void:
	if int(TimesNum1.text) * int(TimesNum2.text) == int(TimesInput.text):
		times_correct = true
		$TimesTick.show()
		$TimesCross.hide()
	else:
		times_correct = false
		$TimesCross.show()
		$TimesTick.hide()


func _on_divide_input_text_changed() -> void:
	if int(DivideNum1.text) / int(DivideNum2.text) == int(DivideInput.text):
		divide_correct = true
		$DivideTick.show()
		$DivideCross.hide()
	else:
		divide_correct = false
		$DivideCross.show()
		$DivideTick.hide()

func _on_plus_input_text_changed() -> void:
	if int(PlusNum1.text) + int(PlusNum2.text) == int(PlusInput.text):
		plus_correct = true
		$PlusTick.show()
		$PlusCross.hide()
	else:
		plus_correct = false
		$PlusCross.show()
		$PlusTick.hide()

func _on_minus_input_text_changed() -> void:
	if int(MinusNum1.text) - int(MinusNum2.text) == int(MinusInput.text):
		minus_correct = true
		$MinusTick.show()
		$MinusCross.hide()
	else:
		minus_correct = false
		$MinusCross.show()
		$MinusTick.hide()
