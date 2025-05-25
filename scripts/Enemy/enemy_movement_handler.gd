extends Node
@export var parent: CharacterBody2D
@export var raycast_wall: RayCast2D
@export var raycast_ledgeR: RayCast2D
@export var raycast_ledgeL: RayCast2D
@export var raycast_jump: RayCast2D 

var direction := 1.0

func move()->bool:
	if parent.SPEED!=0:
		return true
	return true
	#return false

func get_direction()->float:
	if raycast_wall.is_colliding():
			direction *=-1 
	if 	!raycast_ledgeR.is_colliding() and raycast_ledgeL.is_colliding(): 
			direction = -1 
	elif !raycast_ledgeL.is_colliding() and raycast_ledgeR.is_colliding(): 
			direction = 1 
	return direction

func want_jump()->bool:
	if raycast_jump.is_colliding() and !raycast_wall.is_colliding():
		return true	
	return false
