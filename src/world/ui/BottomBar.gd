class_name BottomBar extends Control

@export var creature_attributes: CreateAttributes = null
@onready var hunger: AttributteDisplay = $GridContainer/Hunger
@onready var energy: AttributteDisplay = $GridContainer/Energy
@onready var excitement: AttributteDisplay = $GridContainer/Excitement
@onready var thirst: AttributteDisplay = $GridContainer/Thirst

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	hunger.set_new_value(creature_attributes.hunger)
	thirst.set_new_value(creature_attributes.thirst)
	energy.set_new_value(creature_attributes.energy)
	excitement.set_new_value(creature_attributes.excitement)
