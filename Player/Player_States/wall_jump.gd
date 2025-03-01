extends Node

var WALL_JUMP_VELOCITY:= -200

func exe(info: PlayerStateInfo) -> void:
	var player:= info.player
	var wall_normal_x = player.get_collision_normal_x()

	player.velocity.y = WALL_JUMP_VELOCITY
	player.jump_held_time += info.delta

	if wall_normal_x != 0:
		player.velocity.x = -wall_normal_x * WALL_JUMP_VELOCITY
		
