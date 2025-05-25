extends State


# export states that it may transition to
@export
var idle_state: State
@export
var fall_state: State
@export
var jump_state: State

@export
var SPEED: int=100
# how to make this same as parent.speed??? like a cool way of doint it

var direction

func enter():
	super()

func process_physics(delta: float)->State:
	direction= get_direction()
	parent.velocity.y+= gravity*delta
	
#Flip sprite and attack dir
	if direction != 0:
		parent.animations.flip_h= direction<0
		if parent.flippable:
			for obj in parent.flippable:
				obj.scale.x=direction

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
	return null	
