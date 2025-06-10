extends State

@export var fall_state: State
@export var idle_state: State
@export var run_state: State
@export var chase_state: State
@export var hurt_state: State

var direction 

func enter():
	super()
	parent.velocity.y=JUMP

func process_physics(delta: float) -> State:
	parent.velocity.y+= gravity*delta
	if parent.velocity.y>0:
		return fall_state	
	direction= get_direction()
#Flip assets if needed
	if direction != 0:
		flip_assets(direction)
# change the above to incase parent doesnt have attack?	idk
	if SPEED:
		parent.velocity.x = direction * SPEED
	parent.move_and_slide()
	if parent.is_on_floor():
		if direction!=0:
			if parent.SEEN:
				return chase_state
			return run_state
		return idle_state
	return null

func damage_taken(attack):
	hurt_state.attack=attack
	return hurt_state
