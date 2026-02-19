class_name CreatureStateMachine extends Node

@export var debug_on: bool = false
var states: Dictionary = {}
var active_state: CreatureStateBase = null
var rigs_set: bool = false


func _ready():
	for it: CreatureStateBase in get_children():
		states[it.name] = it
		it.state_machine = self


func set_rigs(rig_front: RigBase, rig_side: RigBase):
	for it in states.keys():
		var state: CreatureStateBase = states[it]
		state.rig_front = rig_front
		state.rig_side = rig_side 
	rigs_set = true
	active_state = states["Falling"]


func get_state_names() -> Array[String]:
	return states.keys()


func switch_to_state(state_name: String) -> void:
	if state_name in states.keys():
		var state:CreatureStateBase = states[state_name]
		if active_state != null:
			active_state._on_state_change_out()
		state._on_state_change_in()
		active_state = state
	else:
		push_error("NO STATE WITH THAT NAME: " + state_name + " IN PLAYER STATE MACHINE")


#Tick function
func _process_states(input:Dictionary) -> void:
	if active_state != null:
		active_state.process_state(input)
		
