class_name CreatureStateMachine extends Node

@export var debug_on: bool = false
@export var walkable_area: Polygon2D = null
@export var creature: Creature = null

enum ERigs {
	FRONT = 0,
	SIDE,
	REAR
}

var rigs: Dictionary = {
	ERigs.FRONT: null,
	ERigs.SIDE: null,
	ERigs.REAR: null
}
var states: Dictionary = {}
var active_state: CreatureStateBase = null
var rigs_set: bool = false


func _ready():
	for it: CreatureStateBase in get_children():
		states[it.name] = it
		it.state_machine = self


func set_rigs(rig_front: RigBase, rig_side: RigBase, rig_rear: RigBase):
	for it in states.keys():
		var state: CreatureStateBase = states[it]
		state.state_machine = self
	rigs[ERigs.FRONT] = rig_front
	rigs[ERigs.SIDE] = rig_side
	rigs[ERigs.REAR] = rig_rear
	rigs_set = true


func get_state_names() -> Array[String]:
	return states.keys()

func get_active_state_name() -> String:
	if active_state != null:
		return active_state.name
	return String()

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
func _process_states(_delta:float) -> void:
	if active_state != null:
		active_state.process_state(_delta)
		
