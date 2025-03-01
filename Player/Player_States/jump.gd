extends Node

@onready var air_strafe:= $Air_Strafe

func exe(info: PlayerStateInfo) -> void:
	var player:= info.player
	player.animations.play("jump", .01)
	if player.velocity.y == 0 || player.is_jumping:
		player.velocity.y = player.JUMP_VELOCITY
	air_strafe.exe(info)
