extends Node

func exe(info: PlayerStateInfo) -> void:
	#play animation
	#animated_sprite.play("run")
	var player:= info.player
	var direction:= info.h_direction

		
	if direction:
		var target_velocity = direction * player.SPEED
		
		if player.velocity.x * direction > player.SPEED:
			player.velocity.x = move_toward(player.velocity.x, target_velocity, 10)
		else:
			player.velocity.x = direction * player.SPEED
			
		
		player.animations.play("run", .3)

		
