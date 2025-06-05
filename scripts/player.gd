extends Area2D

var hp := 5
@rpc("authority")

func take_damage(amount: int) -> void:
	# Only the server runs this code
	hp -= amount
	print("Server: Player hit! HP:", hp)
	
	# Broadcast updated HP to everyone
	rpc("update_hp", hp)
	
	if hp <= 0:
		rpc("die")

@rpc("any_peer")
func update_hp(new_hp: int) -> void:
	# Everyone updates local HP (including server)
	hp = new_hp
	print("Updated HP on peer:", hp)

@rpc("any_peer","call_local")
func die() -> void:
	print("You died!")
	get_parent().queue_free()
