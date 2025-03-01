extends Node

@onready var ground_attack:= $Ground_Attack
@onready var air_attack:= $Air_Attack
@onready var wall_attack:= $Wall_Attack

func exe(info: PlayerStateInfo, attack: CombatManager.AttackTypes) -> void:
	var player = info.player
	if player.is_on_floor:
		ground_attack.exe(info, attack)
	elif player.is_on_wall_only:
		wall_attack.exe(info, attack)
	else:
		air_attack.exe(info, attack)
		
