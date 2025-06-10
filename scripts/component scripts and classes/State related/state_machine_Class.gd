class_name State_Machine
extends Node

@export var starting_state: State

var current_state: State
var SPEED: int
var JUMP :int

func init(parent: CharacterBody2D, 
			movement_handler, hitbox,
			animations : AnimatedSprite2D , 
			Speed, Jump)->void:
	# Set parent for all states in the machine 
	for child in get_children():
		child.parent=parent
		child.movement_handler=movement_handler
		child.animations=animations
		child.SPEED=Speed
		child.JUMP=Jump
		if hitbox:
			child.hitbox=hitbox
			hitbox.damage_taken.connect(damage_taken)
	# enter starting state
	change_state(starting_state)

func damage_taken(attack):
	var new_state=current_state.damage_taken(attack)
	if new_state:
		change_state(new_state)

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
