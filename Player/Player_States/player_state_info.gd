class_name PlayerStateInfo extends Node

var player: CharacterBody2D
var h_direction: float = 0
var v_direction: float = 0
var delta: float = 0

func _init(init_player: CharacterBody2D, init_h_direction: float, init_v_direction: float, init_delta: float) -> void:
	player = init_player
	h_direction = init_h_direction
	v_direction = init_v_direction
	delta = init_delta
	
