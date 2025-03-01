class_name PlayerStateManager extends Node

var player: CharacterBody2D
var current_state: Node = idle_node
var current_state_name: String = "IDLE"

enum PlayerState {
	IDLE,
	RUN,
	JUMP,
	FALL,
	CLIMB,
	WALL_JUMP,
	WALL_SLIDE,
	DIE,
	DASH,
	WALL_HOLD
}

@onready var idle_node:= $Idle
@onready var run_node:= $Run
@onready var jump_node:= $Jump
@onready var fall_node:= $Fall
@onready var climb_node:= $Climb
@onready var wall_jump_node:= $Wall_Jump
@onready var wall_hold_node:= $Wall_Hold
@onready var wall_slide_node:= $Wall_Slide
@onready var die_node:= $Die
@onready var dash_node:= $Dash

var state_map: Dictionary[PlayerState, Node]

func _ready() -> void:
	state_map = {
		PlayerState.IDLE: idle_node,
		PlayerState.RUN: run_node,
		PlayerState.JUMP: jump_node,
		PlayerState.FALL: fall_node,
		PlayerState.CLIMB: climb_node,
		PlayerState.WALL_JUMP: wall_jump_node,
		PlayerState.WALL_HOLD: wall_hold_node,
		PlayerState.WALL_SLIDE: wall_slide_node,
		PlayerState.DIE: die_node,
		PlayerState.DASH: dash_node,
	}

func set_current_state(new_state: PlayerState) -> void:
	if current_state != state_map[new_state]:
		current_state = state_map[new_state]
		current_state_name = PlayerState.keys()[new_state]
		SignalHandler.update_state.emit(current_state_name)
	
func set_player(new_player: CharacterBody2D) -> void:
	player = new_player
	
