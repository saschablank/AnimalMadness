class_name WorldUi extends Control

@export var creature: Creature = null
@onready var bottom_bar: BottomBar = $BottomBar

signal _on_start_building_mode()
signal _on_feed_creature()
signal _on_pet_creature()
signal _on_play_with_creature()

func _ready() -> void:
	bottom_bar.creature_attributes = creature.get_attributes()


func _process(_delta: float) -> void:
	pass


func _on_button_wheel__on_building_mode() -> void:
	_on_start_building_mode.emit()


func _on_button_wheel__on_feed() -> void:
	_on_feed_creature.emit()


func _on_button_wheel__on_pet() -> void:
	_on_pet_creature.emit()


func _on_button_wheel__on_play() -> void:
	_on_play_with_creature.emit()
