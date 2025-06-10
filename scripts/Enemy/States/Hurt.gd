extends State

@export var fall_state: State
@export var idle_state: State
@export var run_state: State
@export var chase_state: State
@export var jump_state: State

var attack: Attack
var timer: float
var direction 

func enter():
	timer = hitbox.knockbackDur/4
	parent.modulate = Color(100,1,1)
	print("HURT STATE")
	super()	

func exit():
	parent.modulate= Color(1,1,1)

func process_physics(delta: float)->State:
	parent.velocity.y+= gravity*delta
	parent.move_and_slide()
	timer -= delta
	parent.move_and_slide()
	print("TIMER", timer)
	if timer <=0:
		if !parent.is_on_floor():
			return fall_state
		if want_jump():
			return jump_state
		if move(): 
			return run_state
		if parent.SEEN:
			return chase_state
		return idle_state
	return null
