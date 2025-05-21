extends CharacterBody2D
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2DEnemy
@onready var raycast_wall: RayCast2D = %RayCastWall
@onready var raycast_ledgeR: RayCast2D = %RayCastLedgeRight
@onready var raycast_ledgeL: RayCast2D = %RayCastLedgeLeft
@onready var raycast_jump: RayCast2D = %RayCastJump



# NOTE !! Raycasting (and I assume of
# slightly slower and less jumpy than player
const SPEED = 90.0
const JUMP_VELOCITY = -250.0
const WALL_RAYCAST_LEN= 10

var direction := 1 # 1 and -1 for where its facing, 0 if still ig


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
### enemy cannot change direction due to wall when falling ###
	else:
		# add wall detection logic
		if raycast_wall.is_colliding():
			direction = direction * (-1) # flip direction
		elif raycast_jump.is_colliding():
			velocity.y = JUMP_VELOCITY # If no wall in top half but wall at knees, jump
	# add ledge detection logic
	if 	not raycast_ledgeR.is_colliding(): # if ledge on right, turn left
		direction=-1
	if 	not raycast_ledgeL.is_colliding(): # if ledge on left, turn right
		direction=1
	
	#	Flip sprite according to movemebt direction
	if direction > 0: # facing right
		animated_sprite.flip_h= false
		raycast_wall.target_position=Vector2(1, 0.0) * WALL_RAYCAST_LEN
		raycast_jump.target_position=Vector2(1, 0.0) * WALL_RAYCAST_LEN*2
		#raycast_wall.set_target_position()
	elif direction<0: # facing left
		animated_sprite.flip_h= true # ?change this so that it uses fresh spritesheet with proper shading
		raycast_wall.target_position=Vector2(-1, 0.0) * WALL_RAYCAST_LEN
		raycast_jump.target_position=Vector2(-1, 0.0) * WALL_RAYCAST_LEN*2
		#raycast_wall.cast_to = Vector2(-10.0, 0.0) *100
	# Play da correct animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
				
	velocity.x = direction * SPEED 
		#velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
