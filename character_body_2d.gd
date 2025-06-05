extends CharacterBody2D

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
	
@rpc("any_peer", "unreliable")
func sync_position(pos: Vector2):
	global_position = pos

func _physics_process(delta):
	if is_multiplayer_authority():
		velocity = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down") * 200
		move_and_slide()
		sync_position.rpc(global_position)
