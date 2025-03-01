extends Node

@onready var air_idle:= $Air_Idle
@onready var air_strafe:= $Air_Strafe


func exe(info: PlayerStateInfo) -> void:
	#play animation
	var player = info.player
	var delta = info.delta
	var dir = info.h_direction
	player.velocity += player.get_gravity() * delta
	player.animations.play("falling", .3)

#	if the player is already going faster than default speed we just want to decelerate 
	if dir == 0 || player.velocity.length() > player.SPEED:
		air_idle.exe(info)
	else:
		air_strafe.exe(info)
	
	#if (velocity.y > 0):
		#animated_sprite.play("jump")
	#else:
		#animated_sprite.play("fall")

		
