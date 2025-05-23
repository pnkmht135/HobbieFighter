extends Node

@export var starting_state: State

var current_state: State

func init(parent: CharacterBody2D)->void:
	# Set parent for all states in the machine 
	for child in get_children():
		child.parent=parent
		
	# enter starting state
	change_state(starting_state)

func change_state(new_state: State):
	# exit current state if applicable
	if current_state:
		current_state.exit()
	
	# enter new state
	current_state=new_state
	current_state.enter()

func process_physics(delta: float) -> void:
	var new_state = current_state.process_physics(delta)
	
	if new_state:
		change_state(new_state)
		
func process_input(event: InputEvent) -> void:
	var new_state = current_state.process_input(event)
	
	if new_state:
		change_state(new_state)

func process_frame(delta: float):
	var new_state =  current_state.process_frame(delta)
	
	if new_state:
		change_state(new_state)
# check wtf a frame is and why i would need a func for it 
