extends Node

func exe(info: PlayerStateInfo) -> void:
	#play animation
	var player = info.player
	var delta = info.delta
	if player.velocity.y < 0:
		player.velocity += player.get_gravity() * delta
	else:
		player.velocity += player.get_gravity()/4 * delta
		
