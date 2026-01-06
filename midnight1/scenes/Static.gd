extends Node

@export var websocket_url = "ws://foxmoss.com:9003"

var socket = WebSocketPeer.new()

var user_id: int = 0

var names = {}
var is_connected = false
var current_name = ""
signal notify_names

var current_grade = 0
var grade_progress = ["F", "D", "C", "B", "A"]

func _ready():
	randomize()
	user_id = randi()
	
	var err = socket.connect_to_url(websocket_url)
	if(err == OK):
		is_connected = true
	await get_tree().create_timer(0.2).timeout
	socket.send_text(JSON.stringify({"type": "get_name", "uuid": user_id}))

func send_name(name):
	socket.send_text(JSON.stringify({"type": "name", "name": name, "uuid": user_id}))
	current_name = name
	names[roundi(user_id)] = current_name
	print("sendding name")

var last_tick = 0

func _process(_delta):
	socket.poll()
	
	if Time.get_ticks_msec() - last_tick > 3000 && !is_connected:
		last_tick = Time.get_ticks_msec()
		
		var err = socket.connect_to_url(websocket_url)
		print("fetcehd connect")
		if(err == OK):
			is_connected = true

	var state = socket.get_ready_state()
	
	if state == WebSocketPeer.STATE_OPEN:
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
			else:
				print("< Got binary data from server: %d bytes" % packet.size())

	elif state == WebSocketPeer.STATE_CLOSING:
		pass

	elif state == WebSocketPeer.STATE_CLOSED:
		is_connected = false
		
		
