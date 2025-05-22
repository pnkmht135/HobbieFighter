extends Node2D
#const AttackClass = preload("res://scripts/attack_class.gd")
var attack = Attack.new()
@onready var default_aoe: CollisionShape2D = $DefaultAOE

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set attack data
	attack.damage=get_meta("Damage")
	attack.knowckback=get_meta("Knockback")
	attack.key=get_meta("Key")
	attack.cooldown=get_meta("Cooldown")
	attack.speed=get_meta("Speed")
	print("")
	print(attack.damage, attack.key,attack.speed)

	if has_node("AOE"):
		default_aoe.disabled=true#ensure its not going to cause issues
		attack.AOE=$AOE
		default_aoe.queue_free()  # dont need
	else:
		attack.AOE=default_aoe
	attack.AOE.disabled=true # attack does not appear unless button clicked
	print("ok so: ",default_aoe.disabled, attack.AOE.disabled)
	#default_aoe.disabled=true
## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(attack.key):
		enable_attack_hitbox(attack)
		start_attack_cooldown(attack)

func enable_attack_hitbox(attack: Attack):
	attack.AOE.disabled=false
	#default_aoe.disabled=false
	print("attack!! ",attack.AOE.disabled)
	await get_tree().create_timer(attack.speed).timeout
	attack.AOE.disabled= true
	print("ataked ",attack.AOE.disabled)

func start_attack_cooldown(attack: Attack):
	var key=attack.key
	attack.key=""
	print("changed key from ",key," to ",attack.key)
	await get_tree().create_timer(attack.cooldown).timeout
	attack.key=key
	print("cooldown done", attack.key)

func _on_body_entered(body: Node2D) -> void:
	#if typeof(body) == CharacterBody2D:
	print("HIT", body.get_parent())
