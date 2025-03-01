extends Control

@onready var dash_label = $HBoxContainer/VBoxContainer/DashLabel
@onready var jump_label = $HBoxContainer/VBoxContainer/JumpLabel
@onready var state_label = $HBoxContainer/VBoxContainer/StateLabel

@onready var dash_ready_label = $HBoxContainer/VBoxContainer2/DashReadyLabel
@onready var jump_ready_label = $HBoxContainer/VBoxContainer2/JumpReadyLabel
@onready var state_name_label = $HBoxContainer/VBoxContainer2/StateNameLabel


func _ready() -> void:
	SignalHandler.connect("update_state", _on_update_state)
	SignalHandler.connect("update_jumps", _on_update_jumps)
	SignalHandler.connect("update_dashes", _on_update_dashes)
	SignalHandler.connect("dash_ready", _on_dash_ready)
	
func _on_update_state(new_state: String) -> void:
	state_name_label.text = new_state

func _on_update_jumps(jump_count: int) -> void:
	jump_label.text = "Jumps: " + str(jump_count)

		
func _on_update_dashes(dash_count: int) -> void:
	dash_label.text = "Dashes: " + str(dash_count)
	
func _on_dash_ready(cooldown_pct: float) -> void:
	dash_ready_label.text = str(cooldown_pct)

	
