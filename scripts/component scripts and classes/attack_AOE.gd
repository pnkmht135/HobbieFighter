extends Node2D

var attack = Attack.new()
@onready var shape: CollisionShape2D =$shape
var Damage: int
var Knockback: int 
var Cooldown: float

var possible: bool = true

func _ready() -> void:
	shape.disabled=true # attack does not appear unless triggered
	shape.hide()

func trigger_attack_AOE():
	shape.show()
	shape.disabled=false
	#print("attack!! ",shape.disabled)
	#await get_tree().create_timer(Duration).timeout

func remove_attack_AOE():
	shape.disabled= true
	shape.hide()
	#print("ataked ",shape.disabled)

func _on_area_entered(area: Area2D) -> void:
	attack.damage=Damage
	attack.knowckback=Knockback
	#print("something entered")
	if area is Hitbox:
		print("hitbox found")
		area.damage(attack)
	#if it encounters an area that can take damage (a hitbox), damage it
