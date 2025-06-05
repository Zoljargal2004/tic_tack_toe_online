extends CharacterBody2D



@export var bullet: PackedScene

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

@rpc("any_peer", "unreliable")
func sync_position(pos: Vector2):
	global_position = pos

func _physics_process(delta):
	if is_multiplayer_authority():
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * 500
		move_and_slide()
		if Input.is_action_just_pressed("space"):
			shoot()
@export var bullet_scene: PackedScene

func shoot():
	if bullet_scene:
		var bullet = bullet_scene.instantiate()
		
		var direction = (get_global_mouse_position() - global_position).normalized()
		
		# Offset bullet spawn slightly away from shooter
		bullet.global_position = global_position + direction * 100
		
		# Assign direction to bullet
		bullet.direction = direction

		get_tree().current_scene.add_child(bullet)
