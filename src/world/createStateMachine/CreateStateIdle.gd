class_name CreatureStateIdle extends "res://src/world/createStateMachine/CreatureStateBase.gd"

var idle_frame_counter:float = 0
static var idle_max_count = 20


func _on_state_change_in():
	idle_frame_counter = 0
	var rig_front:RigBase = state_machine.rigs[CreatureStateMachine.ERigs.FRONT]
	if rig_front != null:
		rig_front.visible = true
		rig_front.stop_animation()
	else:
		push_error("ERROR: No front rig assinged to the statemachine")


func _on_state_change_out():
	var rig_front:RigBase = state_machine.rigs[CreatureStateMachine.ERigs.FRONT]
	if rig_front != null:
		rig_front.stop_animation()
	rig_front.visible = false


func process_state(delta: float):
	idle_frame_counter += delta
	var rig_front:RigBase = state_machine.rigs[CreatureStateMachine.ERigs.FRONT]
	if rig_front != null:
		rig_front.play_animation(RigBase.EAnimations.IDLE)
	else:
		push_error("ERROR: No front rig assinged to the statemachine")
