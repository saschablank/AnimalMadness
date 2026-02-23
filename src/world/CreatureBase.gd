class_name Creature extends Node2D

@export var walkable_area: Polygon2D = null
@export var iteractables_in_walkable_area: Array[Node2D] = []
@onready var state_machine: CreatureStateMachine = $StateMachine

var new_action_timer: Timer = Timer.new()
var dest_position:Vector2 = Vector2.ZERO
var state = 0


func _ready() -> void:
	new_action_timer.wait_time = 5.0
	new_action_timer.timeout.connect(_do_new_action)
	add_child(new_action_timer)
	new_action_timer.start()


func get_attributes():
	return $Attributes


func _do_new_action():
	pass


func _process(delta: float) -> void:
	if state_machine.rigs_set == false:
		state_machine.set_rigs($bunnoffel_front, $bunnoffel_side, $bunnoffel_rear)
		state_machine.walkable_area = walkable_area
		state_machine.creature = self
		state_machine.switch_to_state("idle")
	else:
		state_machine._process_states(delta)
