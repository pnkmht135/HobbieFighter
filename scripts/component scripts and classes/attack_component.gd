extends Node2D
#const AttackClass = preload("res://scripts/attack_class.gd")
var attack = Attack.new()
@export var AOE: CollisionShape2D
@export var Damage: int =1
@export var Knockback: int =1
@export var Key: String = "Click"
@export var Duration: int =1
@export var Cooldown: int =1
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# set attack data
	attack.damage=Damage
	attack.knowckback=Knockback
	attack.key=Key
	attack.cooldown=Cooldown
	attack.duration=Duration
	
	AOE.disabled=true # attack does not appear unless button clicked
### maybe change it so that enable and disable is handled by the
### player script, such that AOE is not being continuously loaded idk

## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed(attack.key):
		enable_attack_hitbox(attack)
		start_attack_cooldown(attack)

func enable_attack_hitbox(attack: Attack):
	AOE.disabled=false
	#default_aoe.disabled=false
	#print("attack!! ",AOE.disabled)
	await get_tree().create_timer(attack.duration).timeout
	AOE.disabled= true
	#print("ataked ",AOE.disabled)

func start_attack_cooldown(attack: Attack):
	var key=attack.key
	attack.key=""
	#print("changed key from ",key," to ",attack.key)
	await get_tree().create_timer(attack.cooldown).timeout
	attack.key=key
	#print("cooldown done", attack.key)

func _on_area_entered(area: Area2D) -> void:
	#print("something entered")
	if area is Hitbox:
		print("hitbox found")
		area.damage(attack)
	#if it encounters an area that can take damage (a hitbox), damage it
