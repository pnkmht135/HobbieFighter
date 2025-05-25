extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2DEnemy
@onready var raycast_wall: RayCast2D = %RayCastWall
@onready var raycast_ledgeR: RayCast2D = %RayCastLedgeRight
@onready var raycast_ledgeL: RayCast2D = %RayCastLedgeLeft
@onready var raycast_jump: RayCast2D = %RayCastJump
@onready var FOVpolygon: CollisionPolygon2D = $FOV/CollisionPolygon2D
@onready var timer: Timer = $FOV/Timer

# slightly slower and less jumpy than player
@export var SPEED: int = 20.0
@export var CHASE_BOOST: float =1.5
@export var FOLLOWS: bool = true
const JUMP_VELOCITY = -250.0
const WALL_RAYCAST_LEN= 10
const FOV_R_POS:= Vector2(40,-25)

var direction := 1 # 1 and -1 for where its facing, 0 if still ig
var target
var seen:bool = false

func _ready() -> void:
	if not FOLLOWS:
		FOVpolygon.disabled= true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		# add wall detection logic
		if raycast_wall.is_colliding() and SPEED:
			direction = direction * (-1) # flip direction
		elif raycast_jump.is_colliding() and SPEED:
			velocity.y = JUMP_VELOCITY # If no wall in top half but wall at knees, jump
	if seen and FOLLOWS: 
# temporary, probably inefficient: just overwrite any direction changes if seen
		direction=sign((target.position.x-position.x))
		
	# add ledge detection logic
	if 	not raycast_ledgeR.is_colliding(): # if ledge on right, turn left
		direction=-1
	if 	not raycast_ledgeL.is_colliding(): # if ledge on left, turn right
		direction=1
	
	#	Flip sprite according to movemebt direction
	if direction > 0: # facing right
		animated_sprite.flip_h= false
		raycast_wall.target_position=Vector2(1, 0.0) * WALL_RAYCAST_LEN
		raycast_jump.target_position=Vector2(1, 0.0) * WALL_RAYCAST_LEN
		FOVpolygon.rotation=0
		FOVpolygon.position=FOV_R_POS
		
	elif direction<0: # facing left
		animated_sprite.flip_h= true # ?change this so that it uses fresh spritesheet with proper shading
		raycast_wall.target_position=Vector2(-1, 0.0) * WALL_RAYCAST_LEN
		raycast_jump.target_position=Vector2(-1, 0.0) * WALL_RAYCAST_LEN
		FOVpolygon.position=Vector2(-FOV_R_POS.x,FOV_R_POS.y)
		FOVpolygon.rotation=PI
	# Play da correct animations
	if is_on_floor():
		if not SPEED:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
				
	if SPEED:
		velocity.x = direction * (SPEED*CHASE_BOOST if seen else SPEED)
	else:
		velocity.x=0
	move_and_slide()

## if 
func _on_fov_body_entered(body: Node2D) -> void:
	target = body
	print("I SEE YOU!!")
	#timer.stop() # is not having this better??
	seen=true

func _on_fov_body_exited(body: Node2D) -> void:
	timer.start()

func _on_timer_timeout() -> void:
	print("Mustve been the wind...")
	seen=false
