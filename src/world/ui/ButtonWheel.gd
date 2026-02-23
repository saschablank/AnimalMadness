extends Control

signal _on_feed()
signal _on_pet()
signal _on_building_mode()
signal _on_play()

@onready var subbuttons: Control = $subbuttons

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	subbuttons.visible = false

func _on_button_pressed() -> void:
	subbuttons.visible = !subbuttons.visible


func _on_feed_pressed() -> void:
	_on_feed.emit()


func _on_pet_pressed() -> void:
	_on_pet.emit()


func _on_building_mode_pressed() -> void:
	_on_building_mode.emit()


func _on_play_pressed() -> void:
	_on_play.emit()
