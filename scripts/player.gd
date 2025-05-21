extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var player: CharacterBody2D = $"."
@onready var death_timer: Timer = $Hitbox/Timer

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Move_left", "Move_right")
#	Flip sprite
	if direction > 0:
		animated_sprite.flip_h= false
	elif direction<0:
		animated_sprite.flip_h= true # change this so that it uses fresh spritesheet with proper shading
	
	# Play da correct animations
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("Idle")
		else:
			animated_sprite.play("Run")
	else:
		animated_sprite.play("Jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


# Death detection for environmental hazards (collision mask/layer 3 using hitbox)
func _on_hitbox_body_entered(body: Node2D) -> void:
	#Engine.time_scale=0.5
	print("you died! Environmental Hazard")
	player.get_node("CollisionShape2D").queue_free()
	death_timer.start()

func _on_timer_timeout() -> void:
	get_tree().reload_current_scene()
