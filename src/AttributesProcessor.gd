class_name AttributesProcessor extends Node

@onready var attributes: CreateAttributes = $"../Attributes"
@onready var state_machine: CreatureStateMachine = $"../StateMachine"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


func _calc_next_action():
	pass


func _process(_delta: float) -> void:
	if state_machine.get_active_state_name() == "idle":
		if state_machine.get_idle_frame_counter() >= CreatureStateIdle.idle_max_count:
			state_machine.switch_to_state("walk")
			
	
