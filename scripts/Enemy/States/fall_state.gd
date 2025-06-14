extends State

@export var run_state:State
@export var idle_state:State
@export var chase_state:State
@export var hurt_state:State

var direction

func process_physics(delta: float) -> State:
	parent.velocity.y+= gravity*delta
	parent.move_and_slide()
	direction = get_direction()
	if parent.is_on_floor():
		if parent.SEEN:
			return chase_state
		if direction!=0 and parent.SPEED:
			return run_state
		return idle_state	
	if SPEED:
		parent.velocity.x = direction * SPEED
	return null

func process_input(event:InputEvent): #redundancy??!!
	direction = get_direction()
	if direction!=0 and parent.is_on_floor():
		if parent.SEEN:
			return chase_state
		return run_state
	#Flip assets if needed
	elif direction != 0:
		flip_assets(direction)
	return null

func damage_taken(attack):
	hurt_state.attack=attack
	return hurt_state
