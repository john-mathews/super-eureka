extends Node

const STRAFE_ACCEL:= 10

func exe(info: PlayerStateInfo) -> void:
	#play animation
	#animated_sprite.play("run")
	var player:= info.player
	var direction:= info.h_direction

	if direction:
		var target_velocity = direction * player.SPEED
		
		if abs(player.velocity.x) > player.SPEED:
			player.velocity.x = move_toward(player.velocity.x, target_velocity, STRAFE_ACCEL)
		else:
			player.velocity.x += direction * player.SPEED * STRAFE_ACCEL * info.delta
			


		
