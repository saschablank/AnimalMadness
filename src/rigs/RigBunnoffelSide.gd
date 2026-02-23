extends "res://src/rigs/RigBase.gd"

var animation_mapping: Dictionary = {
	RigBase.EAnimations.WALK_SLOW: "idle_side" 
		
}



func play_animation(index: EAnimations):
	if animation_player != null:
		if animation_player.current_animation != animation_mapping[index]:
			animation_player.stop()
		if animation_player.is_playing() == false:
			animation_player.play(animation_mapping[index])
	else:
		print(name + " NO ANIMATION PLAYER")
