extends Area2D

@export var speed := 500.0
var direction := Vector2.ZERO

func _physics_process(delta):
	position += direction * speed * delta

func _on_Bullet_area_entered(area: Node) -> void:
	if area.is_in_group("Player"):
		if area.has_method("take_damage"):
			area.take_damage(1)  # or any value
		queue_free()  # Destroy bullet on hit


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("Player"):
		if area.has_method("take_damage"):
			area.take_damage(1)
		queue_free()
