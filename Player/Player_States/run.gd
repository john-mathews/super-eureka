extends Node

func exe(info: PlayerStateInfo) -> void:
	#play animation
	#animated_sprite.play("run")
	var player:= info.player
	var direction:= info.h_direction
	#if direction > 0: 
		#info.player.animated_sprite.flip_h = false
	#if direction < 0:
		#player.animated_sprite.flip_h = true
		
	if direction:
		player.velocity.x = direction * player.SPEED
		player.animations.play("run", .3)
		if direction < 0:
			pass
		elif direction > 0:
			pass
		
