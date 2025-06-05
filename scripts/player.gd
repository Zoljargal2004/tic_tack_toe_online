extends Area2D
var hp := 5

func take_damage(amount: int):
	hp -= amount
	print("Player hit! HP:", hp)
	if hp <= 0:
		die()

func die():
	print("You died!")
	get_parent().queue_free()
