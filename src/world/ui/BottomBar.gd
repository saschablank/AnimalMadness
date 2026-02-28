class_name BottomBar extends Control

@export var creature_attributes: CreateAttributes = null
@onready var energy: AttributteDisplay = $Panel/HBoxContainer/GridContainer/Energy
@onready var hunger: AttributteDisplay = $Panel/HBoxContainer/GridContainer/Hunger
@onready var thirst: AttributteDisplay = $Panel/HBoxContainer/GridContainer/Thirst
@onready var excitement: AttributteDisplay = $Panel/HBoxContainer/GridContainer/Excitement


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if creature_attributes != null:
		hunger.set_new_value(creature_attributes.hunger)
		thirst.set_new_value(creature_attributes.thirst)
		energy.set_new_value(creature_attributes.energy)
		excitement.set_new_value(creature_attributes.excitement)
