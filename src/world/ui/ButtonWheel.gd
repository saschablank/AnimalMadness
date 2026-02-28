@tool

extends Control

signal _on_feed()
signal _on_pet()
signal _on_building_mode()
signal _on_play()
signal _on_shop()

@export var editor_reload: bool = false
@export var radius_from_center:float = 100.0
@export var start_angle:Vector2 = Vector2(-1.0,0.0)
@export var end_angle: Vector2 = Vector2(1.0,0)
@export var base_angle_step_degrees: int = 25
@onready var subbuttons: Control = $subbuttons
var is_poped_out = false
var reload:bool = true
var current_angle_degrees = 0

func _ready() -> void:
	pass
	

func _place_buttons():
	current_angle_degrees = rad_to_deg(start_angle.angle())
	for i in range(0, subbuttons.get_child_count()):
		var btn: Button = subbuttons.get_child(i)
		var current_angle_radians = deg_to_rad(current_angle_degrees)
		btn.position = $Button.position + ($Button.size / 4) + Vector2(cos(current_angle_radians) * radius_from_center, 
			sin(current_angle_radians)*radius_from_center)
		current_angle_degrees += (180.0 / (subbuttons.get_child_count() + 1)) + base_angle_step_degrees
		print(current_angle_degrees)


func _process(_delta: float) -> void:
	if (Engine.is_editor_hint() == true and editor_reload == true) or reload == true:
		reload = false
		editor_reload = false
		_place_buttons()


func _on_button_pressed() -> void:
	if is_poped_out == false:
		$AnimationPlayer.play("pop_out")
	else:
		$AnimationPlayer.play_backwards("pop_out")
	is_poped_out = !is_poped_out

func _on_feed_pressed() -> void:
	_on_feed.emit()


func _on_pet_pressed() -> void:
	_on_pet.emit()


func _on_building_mode_pressed() -> void:
	_on_building_mode.emit()


func _on_play_pressed() -> void:
	_on_play.emit()


func _on_shop_pressed() -> void:
	_on_shop_pressed()
