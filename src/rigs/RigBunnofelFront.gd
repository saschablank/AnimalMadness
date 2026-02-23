extends RigBase

var animation_mapping: Dictionary = {
	RigBase.EAnimations.IDLE: "idle_front",
		
}


func play_animation(index: EAnimations):
	if animation_player != null:
		if animation_player.current_animation != animation_mapping[index]:
			animation_player.stop()
		if animation_player.is_playing() == false:
			animation_player.play(animation_mapping[index])
