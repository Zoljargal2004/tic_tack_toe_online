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


#This one joins the Lobby
func join_game(ip: String, port := DEFAULT_PORT) -> void:
	var peer := ENetMultiplayerPeer.new()
	peer.create_client(ip, port)
	multiplayer.multiplayer_peer = peer
	_is_host = false
	print("Joining %s:%d" % [ip, port])
