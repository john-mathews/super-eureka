extends Node

func exe(info: PlayerStateInfo) -> void:
	#play animation
	#animated_sprite.play("idle")
	var player = info.player
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.animations.play("idle", .5)


		
