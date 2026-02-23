class_name AttributesProcessor extends Node

@onready var attributes: CreateAttributes = $"../Attributes"
@onready var state_machine: CreatureStateMachine = $"../StateMachine"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if state_machine.get_active_state_name() == "idle":
		state_machine.switch_to_state("walk")
	
