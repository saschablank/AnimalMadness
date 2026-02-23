class_name RigBase extends Node2D

#######
# DOC:
# This class reperesents the base class of all Creatature rigs.
# It holds a enum with all Animations a create can play
# Every derived class needs to implement the play_animation(EAnimations) function
# to play the animation.
# Every Rig which has a derived class script attached need to have a 
# Animationplayer node attached as child


enum EAnimations {
	IDLE = 0,
	IDLE_UP,
	WALK_SLOW,
	WALK_SLOW_UP,
	WALK_FAST,
	WALK_FAST_UP,
	GET_SLEEPY,
	GET_SLEEPY_SIDE,
	SLEEP_INIT_SIDE,
	SLEEP,
	SLEEP_SIDE,
	EAT
}

@export var animation_player: AnimationPlayer = null


func _ready():
	animation_player = get_node("AnimationPlayer")
	if animation_player == null:
		push_error("ERROR: No animation player in rig assinged")


func play_animation(_index: EAnimations):
	pass


func stop_animation():
	if animation_player != null:
		animation_player.stop()


func flip_x_axis(to_left:bool):
	if to_left == true:
		scale.x = 0.3
	else:
		scale.x = -0.3


func flip_y_axis(to_bottom: bool):
	if to_bottom == true:
		scale.y = 0.25
	else:
		scale.y = -0.25
	
