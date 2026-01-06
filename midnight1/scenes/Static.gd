extends Node

@export var websocket_url = "ws://foxmoss.com:9003"

var socket = WebSocketPeer.new()

var user_id: int = 0
var murderer_id: int = 0

var names = {}
var is_connected = false
var current_name = ""
signal notify_names
var is_dead = false

var current_grade = 0
var grade_progress = ["F", "D", "C", "B", "A"]

func _ready():
	randomize()
	user_id = randi()
	
	var err = socket.connect_to_url(websocket_url)
	if(err == OK):
		is_connected = true
	await get_tree().create_timer(0.2).timeout

func send_name(name):
	socket.send_text(JSON.stringify({"type": "name", "name": name, "uuid": user_id}))
	current_name = name
	names[roundi(user_id)] = current_name
	print("sendding name")


func send_kill(uuid):
	socket.send_text(JSON.stringify({"type": "kill", "target_uuid": uuid}))

func start_game():
	var murder_index = randi_range(0, names.size()-1)
	socket.send_text(JSON.stringify({"type": "start_game", "murderer_uuid": names.keys()[murder_index]}))

func send_to_voting():
	socket.send_text(JSON.stringify({"type": "send_to_voting"}))


var last_tick = 0
var first_open = true

func _process(_delta):
	socket.poll()
	
	if Time.get_ticks_msec() - last_tick > 3000 && !is_connected:
		last_tick = Time.get_ticks_msec()
		
		var err = socket.connect_to_url(websocket_url)
		print("fetcehd connect")
		if(err == OK):
			first_open = true
			is_connected = true

	var state = socket.get_ready_state()
	
	if state == WebSocketPeer.STATE_OPEN:
		if first_open:
			socket.send_text(JSON.stringify({"type": "get_name", "uuid": user_id}))
			
			first_open = false
		while socket.get_available_packet_count():
			var packet = socket.get_packet()
			if socket.was_string_packet():
				var packet_text = packet.get_string_from_utf8()
				print("< Got text data from server: %s" % packet_text)
				var packet_data = JSON.parse_string(packet.get_string_from_utf8())
				if(packet_data["type"] == "get_name"):
					send_name(current_name)
					print("sending names")
					
				if(packet_data["type"] == "name"):
					names[roundi(packet_data["uuid"])] = packet_data["name"]
					notify_names.emit()
					print("emiting")
				
				if(packet_data["type"] == "remove_me"):
					names[roundi(packet_data["uuid"])] = null
					notify_names.emit()
					
				if(packet_data["type"] == "kill"):
					if packet_data["target_uuid"] == user_id:
						get_tree().change_scene_to_file("res://scenes/bsod.tscn")
						is_dead = true
				if(packet_data["type"] == "start_game"):
					murderer_id = packet_data["murderer_uuid"]
					if packet_data["murderer_uuid"] == user_id:
						get_tree().change_scene_to_file("res://scenes/murderer.tscn")
					else:
						get_tree().change_scene_to_file("res://Scenes/MainInterface/HomePage.tscn")
				if(packet_data["type"] == "send_to_voting" && !is_dead):
						get_tree().change_scene_to_file("res://scenes/voting.tscn")
			else:
				print("< Got binary data from server: %d bytes" % packet.size())

	elif state == WebSocketPeer.STATE_CLOSING:
		socket.send_text(JSON.stringify({"type": "remove_me", "uuid": user_id}))

	elif state == WebSocketPeer.STATE_CLOSED:
		is_connected = false
		
		
func grade():
	return grade_progress[current_grade]
