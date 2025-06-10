extends State

@export var idle_state: State
@export var fall_state: State
@export var jump_state: State
@export var chase_state: State
@export var hurt_state: State

var direction

func enter():
	super()

func process_physics(delta: float)->State:
	direction= get_direction()
	parent.velocity.y+= gravity*delta
#Flip sprite and attack dir
	if direction != 0:
		flip_assets(direction)
	if SPEED:
		parent.velocity.x = direction * SPEED 
	parent.move_and_slide()	
	if !parent.is_on_floor():
		return fall_state
	if direction==0:
		return idle_state
	return null

func process_input(event: InputEvent)->State:
	if want_jump() and parent.is_on_floor():
		return jump_state	
	if parent.SEEN and parent.is_on_floor():
		return(chase_state)	
	return null	

func damage_taken(attack):
	hurt_state.attack=attack
	return hurt_state
