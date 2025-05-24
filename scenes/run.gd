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

var direction

func enter():
	super()

func process_physics(delta: float)->State:
	direction= Input.get_axis("Move_left", "Move_right")
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
	#if parent.is_on_floor():
	if Input.is_action_pressed("Jump") and parent.is_on_floor():
		return jump_state		
	return null	
