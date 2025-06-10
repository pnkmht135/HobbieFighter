class_name State
extends Node

@export var animation_name: String

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
var parent: CharacterBody2D
var movement_handler: Node #change to be its own class
var hitbox: Hitbox 
var SPEED: int
var JUMP: int
var animations: AnimatedSprite2D

#func connect_hitbox():
	##print(parent.name, name," hitbox connected!")
	#hitbox.damage_taken.connect(damage_taken)

func damage_taken(attack:Attack)-> State:
	return null

func enter() ->void:
### Check if has animations (should have)
	if animations: 
		animations.play(animation_name)
	else:
		print("WARNING: no sprite animations found for ", parent.name, self.name)

func exit()-> void:
	pass
	
func process_physics(delta: float) -> State:
	return null

func process_input(event: InputEvent)->State:
	return null

func process_frame(delta: float)->State:
	return null
	
func want_jump()->bool:
	return movement_handler.want_jump()

func move()->bool:
	return movement_handler.move()
	
func get_direction()->float:
	return movement_handler.get_direction()

func flip_assets(direction: int)->void:
	animations.flip_h= direction<0
	if parent.fliplist:
		for obj in parent.fliplist:
			obj.scale.x=direction
	else:
		print ("No fliplist", parent.name, self.name)
	
