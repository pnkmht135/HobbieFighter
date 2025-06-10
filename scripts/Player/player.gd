extends CharacterBody2D

@onready var state_machine=$state_machine
@onready var animations: AnimatedSprite2D = $animations
@export var movement_handler: Node 
@export var SPEED = 100
@export var JUMP_VELOCITY = -450

# Flippable objects prepared:
@onready var fliplist: Array[Node] = [
	$attack1AOE,
	$attack2AOE
	]

func _ready() -> void:
# initialise the state machine and pass itself to the function
	state_machine.init(self, movement_handler, null, animations,SPEED,JUMP_VELOCITY)
	
func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _process(delta: float) -> void:
	pass
# apparently _process handles non-physics logic like animating sprites?!
