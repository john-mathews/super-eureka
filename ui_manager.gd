extends Control

@onready var dash_label = $HBoxContainer/VBoxContainer/DashLabel
@onready var jump_label = $HBoxContainer/VBoxContainer/JumpLabel
@onready var state_label = $HBoxContainer/VBoxContainer/StateLabel

@onready var dash_ready_label = $HBoxContainer/VBoxContainer2/DashReadyLabel
@onready var jump_ready_label = $HBoxContainer/VBoxContainer2/JumpReadyLabel
@onready var state_name_label = $HBoxContainer/VBoxContainer2/StateNameLabel


func _ready() -> void:
	SignalHandler.connect("update_state", _on_update_state)
	SignalHandler.connect("dash_ready", _on_dash_ready)
	SignalHandler.connect("update_stamina", _on_update_stamina)
	
	
func _on_update_state(new_state: String) -> void:
	state_name_label.text = new_state

func _on_update_stamina(stamina: float) -> void:
	jump_label.text = str(stamina)
	
func _on_dash_ready(cooldown_pct: float) -> void:
	dash_ready_label.text = str(cooldown_pct)

	
