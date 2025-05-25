extends Node
@export var parent: CharacterBody2D

func move()->bool:
	return (Input.is_action_pressed("Move_left") or Input.is_action_pressed("Move_right"))

func get_direction()->float:
	return Input.get_axis('Move_left', 'Move_right')

func want_jump()->bool:
	return Input.is_action_just_pressed("Jump")
