class_name  Enemy
extends CharacterBody2D

@export var type: EnemyType

@onready var state_machine=$state_machine
@onready var animations: AnimatedSprite2D = $animations
@onready var raycast_wall: RayCast2D = %RayCastWall
@onready var raycast_ledgeR: RayCast2D = %RayCastLedgeRight
@onready var raycast_ledgeL: RayCast2D = %RayCastLedgeLeft
@onready var raycast_jump: RayCast2D = %RayCastJump
@onready var fov: Area2D = $FOV
@onready var hitbox: Hitbox = $Hitbox

var sight_line: RayCast2D
var chase_timer: Timer 

@export var movement_handler: Node 
@export var FOLLOWS: bool = false
# default fallbacks for enemy stats
var SPEED: int = 10
var JUMP_VELOCITY : int = -30
var JUMP_BLOCKS: int = 2
var CHASE_BOOST: float = 1.5

var SEEN: bool= false
var insideFOV: bool= false

# Flippable objects prepared:
@onready var fliplist: Array[Node] = [
	fov,
	raycast_wall,
	#raycast_ledgeL, # trynna only use one ledge raycaste
	#raycast_ledgeR,
	raycast_jump
	]

func _ready() -> void:
	animations.sprite_frames=type
	SPEED = type.Speed
	JUMP_VELOCITY = type.Jump
	JUMP_BLOCKS=  type.JumpBlocks
	CHASE_BOOST = type.ChaseBoost
	state_machine.init(self,movement_handler, hitbox, animations,SPEED,JUMP_VELOCITY)
	if !FOLLOWS:
		fov.monitorable=false
		fov.monitoring=false
		#fov.get_node("PlayerTracker").set_enabled=false # issue, syntax
		#fov.get_node("PlayerTracker").set_visable=false 
		fov.hide()
	else:
		sight_line = get_node("PlayerTracker")
		chase_timer  = fov.get_node("Timer")

func _physics_process(delta: float) -> void:
	state_machine.process_physics(delta)
	if raycast_jump.is_colliding() or raycast_wall.is_colliding() or !raycast_ledgeL.is_colliding() or !raycast_ledgeR.is_colliding():
		state_machine.process_input(null)
	if FOLLOWS and movement_handler.target: 
		if !SEEN: # see if unseen player in FOV has moved into visible area
			if !sight_line.is_colliding():
				print("SEEN with clear sight line")
				SEEN=true
				chase_timer.stop()
		sight_line.set_target_position(movement_handler.target.global_position-global_position)
		state_machine.process_input(null)

	
func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func _on_fov_body_entered(body: Node2D) -> void:
	if FOLLOWS:
		sight_line.set_target_position(body.global_position-global_position)
		movement_handler.target=body
	# need to handle actual colision detection in phys process :>>>>>> ;-;-;-;-;		
		var space_state = get_world_2d().direct_space_state
		var query = PhysicsRayQueryParameters2D.create(fov.global_position,body.global_position,1)
		var collision = get_world_2d().direct_space_state.intersect_ray(query)
		if !collision: # line of sight isnt clear!
			chase_timer.stop()
			SEEN = true
			state_machine.process_input(null)
			print("SEEN")
		else:
			print("Enemy view is obstructed")

func _on_fov_body_exited(body: Node2D) -> void:
	#insideFOV=false
	if SEEN:
		chase_timer.start()
	else: 
		movement_handler.target= null

func _on_chase_timeout() -> void:
	print("chase ended")
	SEEN = false
	movement_handler.target=null
	state_machine.process_input(null)
