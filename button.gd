extends Button

@onready var sex: Sprite2D = $"../Icon"


func _on_pressed() -> void:
	sex.transform *= 2
