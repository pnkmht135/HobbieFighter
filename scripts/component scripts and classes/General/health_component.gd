extends Node
class_name HealthComponent

@export var MAXHEALTH :=10
@export var damage_bounce:= 3
var health: float
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health = MAXHEALTH

func damage (attack: Attack) -> void:
	print("TOOK -",attack.damage)
	health -= attack.damage
	#parent.velocity.y+= damage_bounce
	if health <=0:
		get_parent().queue_free()

# possibley use _process to display healthbar in the future
