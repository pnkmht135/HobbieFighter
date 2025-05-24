extends State

@export var run_state:State
@export var idle_state:State

@export var Move_speed: int =100

var direction

func process_physics(delta: float) -> State:
	parent.velocity.y+= gravity*delta
	parent.move_and_slide()
	
	direction = Input.get_axis("Move_left", "Move_right")
	if parent.is_on_floor():
		if direction!=0:
			return run_state
		return idle_state
		
	if Move_speed:
		parent.velocity.x = direction * Move_speed
	
	return null

func process_input(event:InputEvent):
	direction = Input.get_axis("Move_left", "Move_right")
	if direction!=0 and parent.is_on_floor():
		return run_state

	#Flip sprite and attack dir
	elif direction != 0:
		parent.animations.flip_h= direction<0
		if parent.flippable:
			for obj in parent.flippable:
				obj.scale.x=direction
	return null
