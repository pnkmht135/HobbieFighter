extends Area2D
class_name Hitbox

@export var health_component: HealthComponent =null
@export var parent : CharacterBody2D
@export var knockbackDur : float = 1
@export var bounce: float = -100

signal damage_taken(attack: Attack)

func damage(attack: Attack):
	print("count in an attack")
	if health_component:
		print("damaging health comp")
		emit_signal("damage_taken",attack)
		health_component.damage(attack)
		
func apply_knockback(direction, attack: Attack):
	if parent is CharacterBody2D: #???
		var knockback= attack.knowckback*direction
		print("knockback of ",direction)
		parent.velocity.x= knockback
		parent.velocity.y=bounce
		await get_tree().create_timer(knockbackDur).timeout
		parent.velocity.x=0
