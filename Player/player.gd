extends CharacterBody2D

@onready var player_state_manager = $PlayerStateManager
@onready var player_combat_manager = $PlayerCombatManager
@onready var animations = $animations
@onready var parts = $parts

const SPEED:= 200.0
const AIR_DRAG:= 2.0
const JUMP_VELOCITY:= -400.0
const MAX_STAMINA:= 500.0

var stamina: float
var stamina_recharge_per_second:= 50.0
var stamina_jump_cost:= 50.0
var stamina_dash_cost:= 200.0

var last_h_dir:= 1.0:
	get():
		return last_h_dir
	set(value):
		last_h_dir = value
		if last_h_dir > 0:
			flip_h = true
		elif last_h_dir < 0:
			flip_h = false
		
var part_scale:= 1.0
		
var flip_h: bool:
	get():
		return flip_h
	set(value):
		flip_h = value
		if flip_h:
			parts.scale.x = 1.0 * part_scale
		else:
			parts.scale.x = -1.0 * part_scale
			

var is_dashing:= false
var dash_cooldown_timer:= 1.0
var dash_refresh_time:= 1.0
var dash_time:= 0.2
var dash_time_counter:= 0.0


var max_jumps:= 3
var jump_counter:= 0
var max_jump_time:= 0.2
var jump_held_time:= 0.0
var is_jumping:= false:
	get():
		return Input.is_action_pressed("jump") && jump_held_time <= max_jump_time 
		
var coyote_time:= 0.1
var time_since_grounded:= 0.0

func _ready() -> void:
	player_state_manager.set_player(self)
	stamina = MAX_STAMINA
	part_scale = parts.scale.x
	SignalHandler.connect_player.emit(self)

func _process(delta: float) -> void:
	var player_state_info = get_player_info(delta)
	player_combat_manager.handle_combo(delta)
	if Input.is_action_just_pressed("light_attack"):
		player_combat_manager.add_to_combo(CombatManager.AttackTypes.LIGHT, player_state_info)
	elif Input.is_action_just_pressed("heavy_attack"):
		player_combat_manager.add_to_combo(CombatManager.AttackTypes.HEAVY, player_state_info)
	
	if stamina < MAX_STAMINA:
		stamina += min(stamina_recharge_per_second * delta, MAX_STAMINA)
		
func _physics_process(delta: float) -> void:
	var h_direction := Input.get_axis("left", "right")
	var v_direction := Input.get_axis("down", "up")
	if h_direction != 0:
		#using this for dashing if no input, will use for attacks too prob
		last_h_dir = h_direction
	var player_state_info = PlayerStateInfo.new(self, h_direction, v_direction, delta)
	if is_on_floor():
		jump_counter = 0
		#delta applied to this in jump state
		jump_held_time = 0.0
		time_since_grounded = 0.0
		if h_direction == 0:
			player_state_manager.set_current_state(PlayerStateManager.PlayerState.IDLE)
		else:
			player_state_manager.set_current_state(PlayerStateManager.PlayerState.RUN)
	#in Air	
	else:
		time_since_grounded += delta
		if is_jumping:
			jump_held_time += delta

		if (time_since_grounded > coyote_time && not is_jumping) || jump_held_time > max_jump_time  || Input.is_action_just_released("jump"):
			player_state_manager.set_current_state(PlayerStateManager.PlayerState.FALL)
			
		if is_on_wall_only() && ! is_jumping:
			jump_counter = 0
			jump_held_time = 0.0
			var wall_normal_x = get_collision_normal_x()
			var input_towards_wall = (h_direction < 0 && wall_normal_x > 0) || (h_direction > 0 && wall_normal_x < 0)
			var input_away_wall = (h_direction < 0 && wall_normal_x < 0) || (h_direction > 0 && wall_normal_x > 0)
			if v_direction == 0 || velocity.y >= 0:
				player_state_manager.set_current_state(PlayerStateManager.PlayerState.WALL_SLIDE)
			if v_direction < 0:
				player_state_manager.set_current_state(PlayerStateManager.PlayerState.WALL_HOLD)
			if input_away_wall:
				player_state_manager.set_current_state(PlayerStateManager.PlayerState.FALL)
				
	if (Input.is_action_just_pressed("dash") && stamina >= stamina_dash_cost) || (is_dashing && dash_time_counter <= dash_time):
		if not is_dashing:
			stamina -= stamina_dash_cost
		is_dashing = true
		player_state_manager.set_current_state(PlayerStateManager.PlayerState.DASH)
		dash_time_counter += delta
	else:
		is_dashing = false
		dash_time_counter = 0.0
		if dash_cooldown_timer > 0:
			dash_cooldown_timer -= delta
		else:
			dash_cooldown_timer = dash_refresh_time
			
	if Input.is_action_just_pressed("jump") && jump_counter < max_jumps && stamina >= stamina_jump_cost:
		stamina = max(stamina - stamina_jump_cost * jump_counter, 0)
		jump_counter += 1
		jump_held_time = 0.0
		if is_on_wall_only():
			player_state_manager.set_current_state(PlayerStateManager.PlayerState.WALL_JUMP)
		else:
			player_state_manager.set_current_state(PlayerStateManager.PlayerState.JUMP)
	

		

	SignalHandler.dash_ready.emit(roundi((1 - dash_cooldown_timer) * 100))
	SignalHandler.update_stamina.emit(stamina)
	var state_node = player_state_manager.current_state
	if state_node != null && state_node.has_method("exe"):
		state_node.exe(player_state_info)
	move_and_slide()

#If an range of an interactable
func can_interact() -> bool:
	return false

func get_collision_normal_x() -> float:
	var collision = get_last_slide_collision()
	if collision:
		var normal = collision.get_normal()

		return normal.x
	return 0.0

func get_player_info(delta: float) -> PlayerStateInfo:
	var h_direction := Input.get_axis("left", "right")
	var v_direction := Input.get_axis("down", "up")

	return PlayerStateInfo.new(self, h_direction, v_direction, delta)
