class_name CombatManager extends Node

@onready var attack_node = $Attack

var all_combos: Array[Combo] 
var possible_combos: Array[Combo]

enum AttackTypes {
	LIGHT,
	HEAVY
}

var current_combo: Array[AttackTypes] = []
var combo_timer:= 0.0
var combo_timeout:= 1.0

func handle_combo(delta: float):
	if current_combo.size() > 0:
		#this will handle input buffer too once implemented
		combo_timer += delta
		if combo_timer > combo_timeout:
			end_combo()

func filter_combos() -> void:
	pass
	

func add_to_combo(attack: AttackTypes, state_info: PlayerStateInfo) -> void:
	current_combo.push_back(attack)
	attack_node.exe(state_info, attack)

func end_combo() -> void:
	current_combo = []

func _on_attack_complete() -> void:
	combo_timer = 0.0
	
func _on_combo_complete() -> void:
	end_combo()
