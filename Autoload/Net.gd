# Autoload/Net.gd
extends Node

const DEFAULT_PORT := 4242
const MAX_PLAYERS  := 2  # host + 1 friend

var _is_host := false

# This one hosts the server locally
func host_game(port := DEFAULT_PORT) -> void:
	var peer := ENetMultiplayerPeer.new()
	peer.create_server(port, MAX_PLAYERS)
	multiplayer.multiplayer_peer = peer
	_is_host = true
	print("Hosting on port %d" % port)

func _on_connected():
	print("Successfully connected!")
	get_tree().change_scene_to_file("res://Game.tscn")

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
