extends Button

@onready var sex: Sprite2D = $"../Icon"

@rpc("any_peer")
func Sex_time():
	sex.transform *= 2
func _on_pressed() -> void:
	Sex_time.rpc()
