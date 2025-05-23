extends State

@export var duration: int=2

@export var fall_state: State
@export var idle_state: State
#@export var run_state: State

var timer

func enter():
	timer=duration #failsafe incase loopnig animation gets linked
	super()

func process_physics(delta: float):
	parent.velocity.y+= gravity*delta
	timer-=delta
	
	if !parent.animations.is_playing() or timer<0:
		return idle_state
	return null
