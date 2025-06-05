extends Node

@export var player_scene: PackedScene

func _ready():
	# Connect signal to spawn players
	multiplayer.peer_connected.connect(_on_peer_connected)
	multiplayer.peer_disconnected.connect(_on_peer_disconnected)

	# Spawn the local player (even if no one else connects)
	_on_peer_connected(multiplayer.get_unique_id())

func _on_peer_connected(id: int):
	if has_node(str(id)):
		return  # Already exists

	var player = player_scene.instantiate()
	player.name = str(id)
	player.set_multiplayer_authority(id)
	add_child(player)
	print("Spawned player for ID:", id)

func _on_peer_disconnected(id: int):
	if has_node(str(id)):
		get_node(str(id)).queue_free()
