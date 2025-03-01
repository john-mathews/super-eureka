extends Node

signal update_state(state_name: String)
signal update_stamina(stamina: float)
signal dash_ready(pct: float)

signal connect_player(player: CharacterBody2D)
