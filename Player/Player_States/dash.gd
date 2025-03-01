extends Node

const DASH_VELOCITY:= 800.0

func exe(info: PlayerStateInfo) -> void:
	#play animation
	var player = info.player
	player.animations.play("dash")
	if info.h_direction == 0:
		player.velocity.x =  player.last_h_dir/abs(player.last_h_dir) * DASH_VELOCITY
	else:
		player.velocity.x = info.h_direction * DASH_VELOCITY
	#falling
	if player.velocity.y > 0:
		player.velocity.y = 0

		
		
