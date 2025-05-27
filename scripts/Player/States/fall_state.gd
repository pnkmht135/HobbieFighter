extends State

@export var run_state:State
@export var idle_state:State

var direction

func process_physics(delta: float) -> State:
	parent.velocity.y+= gravity*delta
	parent.move_and_slide()
	direction = get_direction()
	if parent.is_on_floor():
		if direction!=0:
			return run_state
		return idle_state	
	if SPEED:
		parent.velocity.x = direction * SPEED
	return null

func process_input(event:InputEvent): #redundancy??!!
	direction = get_direction()
	if direction!=0 and parent.is_on_floor():
		return run_state
	#Flip assets if needed
	elif direction != 0:
		flip_assets(direction)

	return null
