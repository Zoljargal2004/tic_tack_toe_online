# scripts/Lobby.gd
extends Control

@onready var host: Button = $Host

@onready var join: Button = $Join
@onready var ip_field: LineEdit = $LineEdit
@onready var status: Label = $Status
@export var player_scene: PackedScene
const DEFAULT_PORT := 4242
const MAX_PLAYERS  := 2  # host + 1 friend

var _is_host := false

# This one hosts the server locally
func host_game(port := DEFAULT_PORT) -> void:
	var peer := ENetMultiplayerPeer.new()
	peer.create_server(port, MAX_PLAYERS)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(_add_player)
	_add_player()
	_is_host = true
	print("Hosting on port %d" % port)
func _add_player(id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)
func _on_connected():
	print("Successfully connected!")

func _on_connection_failed():
	print("Failed to connect to server.")
	# Optional: update UI to tell the user

#This one joins the Lobby
func join_game(ip: String, port := DEFAULT_PORT) -> void:
	var peer := ENetMultiplayerPeer.new()
	var result = peer.create_client(ip, port)

	if result != OK:
		print("Failed to start client peer")
		return

	multiplayer.multiplayer_peer = peer
	_is_host = false
	print("Attempting to join %s:%d" % [ip, port])

	# Wait for connection
	multiplayer.connected_to_server.connect(_on_connected)
	multiplayer.connection_failed.connect(_on_connection_failed)

func _ready():
	host.pressed.connect(_on_Host_pressed)
	join.pressed.connect(_on_Join_pressed)

func _on_Host_pressed():
	host_game()


func _on_Join_pressed():
	join_game(ip_field.text)
	print("Hello")
