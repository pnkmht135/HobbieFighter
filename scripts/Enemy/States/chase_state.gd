extends State

@export var idle_state: State
@export var failed_state: State
@export var fall_state: State
@export var jump_state: State
@export var hurt_state: State

var direction
var CHASE_BOOST=1

func enter():
	super()
	if "CHASE_BOOST" in parent:
		CHASE_BOOST=parent.CHASE_BOOST
		
func process_physics(delta: float)->State:
	direction= movement_handler.target_direction()

	parent.velocity.y+= gravity*delta
#Flip sprite and attack dir
	if get_direction()!= direction:
		print("shit he got away")
		parent.SEEN = false
		movement_handler.target = null
		return failed_state
	if direction != 0:
		flip_assets(direction)
	if SPEED:
		parent.velocity.x = direction * SPEED * CHASE_BOOST
	parent.move_and_slide()	
	if !parent.is_on_floor(): 
		return fall_state
	if !parent.SEEN:
		return idle_state
	return null

func process_input(event: InputEvent)->State:
	if want_jump() and parent.is_on_floor():
		return jump_state	
	if !parent.SEEN:
		if parent.is_on_floor():
			return(idle_state)	
		return(fall_state)
	return null	

func damage_taken(attack):
	hurt_state.attack=attack
	return hurt_state
