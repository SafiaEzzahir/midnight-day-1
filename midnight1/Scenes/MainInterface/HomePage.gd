extends Node2D

var currentpage = null
var pagename = ""

const TasksPage = preload("res://Scenes/MainInterface/TasksPage.tscn")
const GradesPage = preload("res://Scenes/MainInterface/grades_page.tscn")
const MapPage = preload("res://Scenes/MainInterface/Map_Page.tscn")

signal ChangeTaskImg
signal ChangeGradesImg
signal ChangeMapImg

#add map img to map page
#add grade system and cooldown

func _ready():
	var Page = TasksPage.instantiate()
	add_child(Page)
	currentpage = Page
	pagename = "tasks"
	Page.mathsclicked.connect(maths_clicked)
	Page.writingclicked.connect(writing_clicked)
	Page.scienceclicked.connect(science_clicked)
	Page.otherclicked.connect(other_clicked)

func _on_task_tab_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if pagename != "tasks":
			remove_child(currentpage)
			var Page = TasksPage.instantiate()
			add_child(Page)
			Page.mathsclicked.connect(maths_clicked)
			Page.writingclicked.connect(writing_clicked)
			Page.scienceclicked.connect(science_clicked)
			Page.otherclicked.connect(other_clicked)
			currentpage = Page
			pagename = "tasks"
			ChangeTaskImg.emit(true)
			ChangeMapImg.emit(false)
			ChangeGradesImg.emit(false)

func _on_grades_tab_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if pagename != "grades":
			remove_child(currentpage)
			var Page = GradesPage.instantiate()
			add_child(Page)
			currentpage = Page
			pagename = "grades"
			ChangeTaskImg.emit(false)
			ChangeMapImg.emit(false)
			ChangeGradesImg.emit(true)


func _on_map_tab_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if pagename != "map":
			remove_child(currentpage)
			var Page = MapPage.instantiate()
			add_child(Page)
			currentpage = Page
			pagename = "map"
			ChangeTaskImg.emit(false)
			ChangeMapImg.emit(true)
			ChangeGradesImg.emit(false)

func maths_clicked():
	get_tree().change_scene_to_file("res://Scenes/math_minigame.tscn")
	
func writing_clicked():
	get_tree().change_scene_to_file("res://Scenes/match-shape-scene.tscn")

func science_clicked():
	get_tree().change_scene_to_file("res://Scenes/sorter_mini_game.tscn")
	
func other_clicked():
	get_tree().change_scene_to_file("res://Scenes/clock_minigame.tscn")