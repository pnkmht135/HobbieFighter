extends Area2D
class_name Hitbox

@export var health_component: HealthComponent =null
@export var parent : CharacterBody2D
@export var bounce : int = 500

func damage(attack: Attack):
	print("count in an attack")
	if health_component:
		print("damaging health comp")
		health_component.damage(attack)
	if parent:
		print("go flyting bitch")
		parent.velocity=Vector2(attack.knowckback*10,-attack.knowckback*10)
		#-bounce
		#parent.velocity.x=attack.knowckback*10
		#parent.move_and_slide()
		await parent.is_on_floor()
		#while not parent.is_on_floor():
			#parent.velocity.x=attack.knowckback
		#parent.velocity.x=0
		
