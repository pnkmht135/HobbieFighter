extends State

@export var fall_state: State
@export var idle_state: State

#input key?
@export var aoe: Area2D 
@export var Damage: int =1
@export var Knockback: int =1
@export var Duration: float =1
@export var Cooldown: float =1
@export var Frame_number: int =3
@export var Attack_Frame: int =1
var timer

func enter():
	timer=Duration #fail-safe incase loopnig animation gets linked
	aoe.Damage=Damage
	aoe.Knockback=Knockback
	#aoe.Duration=Duration
	aoe.Cooldown=Cooldown
# desired FPS = NumFrames/(Duration in seconds)
	parent.animations.sprite_frames.set_animation_speed(animation_name,Frame_number/Duration)
	super()

func process_physics(delta: float):
	parent.velocity.y+= gravity*delta
	timer-=delta
# should I move this to pocess frame?
	if parent.animations.frame == Attack_Frame:
		aoe.trigger_attack_AOE()
	if !parent.animations.is_playing() or timer<0:
		return idle_state
	return null

func exit():
	aoe.remove_attack_AOE()
