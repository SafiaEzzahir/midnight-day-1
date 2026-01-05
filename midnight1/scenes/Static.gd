extends Node

@export var websocket_url = "ws://localhost:9002"

var socket = WebSocketPeer.new()

var user_id = 0

var names = {}

var new_name: Signal
var connected = false

func _ready():
	randomize()
	user_id = randi()
	
	var err = socket.connect_to_url(websocket_url)
	if(err == OK):
		
	
	socket.send_text(JSON.stringify({"type": "get_name", "uuid": user_id}))

var current_name = ""
func send_name(name):
	socket.send_text(JSON.stringify({"type": "name", "name": name, "uuid": user_id}))
	current_name = name
	names[user_id] = current_name

func _process(_delta):
	socket.poll()

	var state = socket.get_ready_state()
	
	if state == WebSocketPeer.STATE_OPEN:
		while socket.get_available_packet_count():
			var packet = socket.get_packet()
			if socket.was_string_packet():
				var packet_text = packet.get_string_from_utf8()
				print("< Got text data from server: %s" % packet_text)
				var packet_data = JSON.parse_string(packet.get_string_from_utf8())
				if(packet_data["type"] == "get_names"):
					send_name(current_name)
				if(packet_data["type"] == "name"):
					names[packet_data["uuid"]] = packet_data["names"]
					new_name.emit()
			else:
				print("< Got binary data from server: %d bytes" % packet.size())

	elif state == WebSocketPeer.STATE_CLOSING:
		pass

	elif state == WebSocketPeer.STATE_CLOSED:
		await get_tree().create_timer(2).timeout
		var err = socket.connect_to_url(websocket_url)
