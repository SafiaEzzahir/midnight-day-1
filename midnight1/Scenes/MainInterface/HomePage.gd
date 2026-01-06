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

func _on_task_tab_input_event(_viewport: Node, event: InputEvent, _shape_idx: int) -> void:
	if event is InputEventMouseButton:
		if pagename != "tasks":
			remove_child(currentpage)
			var Page = TasksPage.instantiate()
			add_child(Page)
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
