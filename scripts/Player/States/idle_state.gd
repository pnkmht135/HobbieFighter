extends State

# export states that it may transition to
@export var run_state: State
@export var fall_state: State
@export var jump_state: State
@export var attack_state: State
@export var attack2_state: State

@export var stop_slide: float = 0.000000001

func enter():
	super()
	#parent.velocity.x=0 # no movement in Idle state!
	parent.velocity.x = move_toward(parent.velocity.x, 0,stop_slide)

func process_physics(delta: float)->State:
	parent.velocity.y+= gravity*delta
	parent.move_and_slide()
	if !parent.is_on_floor():
		return fall_state
	return null

func process_input(event: InputEvent)->State:
	#if parent.is_on_floor():
	if want_jump() and parent.is_on_floor():
		return jump_state
	if move(): 
		return run_state
	if Input.is_action_just_pressed("Click") and parent.is_on_floor():
		return attack_state
	if Input.is_action_just_pressed("ClickR") and parent.is_on_floor():
		return attack2_state
	return null	
