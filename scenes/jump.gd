extends State

@export var jump_velocity: int = -300
@export var Move_speed: int =100

@export var fall_state: State
@export var idle_state: State
@export var run_state: State

var direction 

func enter():
	super()
	parent.velocity.y=jump_velocity

func process_physics(delta: float) -> State:
	parent.velocity.y+= gravity*delta
	
	if parent.velocity.y>0:
		return fall_state
		
	direction= Input.get_axis("Move_left", "Move_right")
#Flip sprite and attack dir
	if direction != 0:
		parent.animations.flip_h= direction<0
		parent.attack.scale.x=direction
		
# change the above to incase parent doesnt have attack?	idk
	if Move_speed:
		parent.velocity.x = direction * Move_speed
	parent.move_and_slide()

	if parent.is_on_floor():
		if direction!=0:
			return run_state
		return idle_state
	return null

func process_input(event: InputEvent)->State:
	return null
