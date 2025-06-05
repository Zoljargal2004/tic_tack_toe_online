extends CharacterBody2D



@export var bullet: PackedScene

func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())

@rpc("any_peer", "unreliable")
func sync_position(pos: Vector2):
	global_position = pos

func _physics_process(delta):
	if is_multiplayer_authority():
		velocity = Input.get_vector("Left", "Right", "Up", "Down") * 500
		move_and_slide()
		if Input.is_action_just_pressed("space"):
			shoot()
@export var bullet_scene: PackedScene
@rpc("any_peer", "call_local")
func spawn_bullet(position: Vector2, direction: Vector2):
	var bullet = bullet_scene.instantiate()
	bullet.global_position = position
	bullet.direction = direction
	bullet.set_multiplayer_authority(multiplayer.get_remote_sender_id())
	get_tree().current_scene.add_child(bullet)

func shoot():
	var direction = (get_global_mouse_position() - global_position).normalized()
	var position = global_position + direction * 100
	spawn_bullet.rpc(position, direction)
