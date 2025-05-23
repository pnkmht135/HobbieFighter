extends CharacterBody2D

@onready var state_machine=$state_machine
@onready var animations: AnimatedSprite2D = $animations

# Flippable objects prepared:
@onready var attack: Area2D = $Attack

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready() -> void:
# initialise the state machine and pass itself to the function
	state_machine.init(self)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _process(delta: float) -> void:
	pass
# _process (delta) that passes delata to a frame processor in state machine?
# apparently _process handles non-physics logic like animating sprites?!
