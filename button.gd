extends Button

@onready var sex: Sprite2D = $"../Icon"
@onready var Sexist: VideoStreamPlayer = $"../VideoStreamPlayer"

@rpc("any_peer")
func Sex_time():
	sex.transform *= 2
	Sexist.visible = not Sexist.visible
func _on_pressed() -> void:
	Sex_time.rpc()
