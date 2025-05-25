extends CharacterBody2D

@onready var state_machine=$state_machine
@onready var animations: AnimatedSprite2D = $animations

@export var movement_handler: Node 
@export var SPEED: int = 20.0
@export var JUMP_VELOCITY = -400.0
@export var CHASE_BOOST: float =1.5
@export var FOLLOWS: bool = true

# Flippable objects prepared:
@onready var flippable: Array[Node] = [
	$FOV,
	%RayCastWall,
	#%RayCastLedgeLeft, # trynna only use one ledge raycaste
	%RayCastLedgeRight,
	%RayCastJump
	]

func _ready() -> void:
	state_machine.init(self,movement_handler)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)
	state_machine.process_input(null)
	
