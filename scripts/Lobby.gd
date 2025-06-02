# scripts/Lobby.gd
extends Control

@onready var host: Button = $Host

@onready var join: Button = $Join
@onready var ip_field: LineEdit = $LineEdit
@onready var status: Label = $Status

func _ready():
	host.pressed.connect(_on_Host_pressed)
	join.pressed.connect(_on_Join_pressed)

func _on_Host_pressed():
	Net.host_game()
	get_tree().change_scene_to_file("res://Game.tscn")

func _on_Join_pressed():
	Net.join_game(ip_field.text)
	get_tree().change_scene_to_file("res://Game.tscn")
