class_name State
extends Node

@export var animation_name: String
@export var movement_speed: float = 200

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var parent: CharacterBody2D

func enter() ->void:
### Check if parent has animations (should have)
	if parent.animations: 
		parent.animations.play(animation_name)
	else:
		print("WARNING: no sprite animations found for ", parent.name)

func exit()-> void:
	pass
	
func process_physics(delta: float) -> State:
# not automaically applying gravity to parent, incase want states for floating objefcts
# and because the return null limits usage of super() anyway
	return null

func process_input(event: InputEvent)->State:
	return null

func process_frame(delta: float)->State:
	return null
# what is a frame and what do i need to do with it????
	
