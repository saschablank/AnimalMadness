class_name CreatureStateBase extends Node

@export var debug_name: String = ""
@export var state_machine: CreatureStateMachine = null


func _ready():
	pass

func _on_state_change_in():
	pass

func _on_state_change_out():
	pass


func process_state(_input: Dictionary):
	pass 
