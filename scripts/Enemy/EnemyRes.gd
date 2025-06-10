class_name EnemyType
extends SpriteFrames

@export var Health: float
@export var Jump: int
@export var Speed: int
@export var ChaseBoost: float
#@export var Follows: bool

var JumpBlocks= round(-1*Jump/100 -1)
