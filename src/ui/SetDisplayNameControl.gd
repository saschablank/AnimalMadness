class_name SetDisplayNameControl extends Control

signal _on_username_control_continue(new_username: String)

@onready var line_edit: LineEdit = $Panel/VBoxContainer/LineEdit
@onready var error_text: Label = $Panel/VBoxContainer/ErrorText


func _on_continue_btn_pressed() -> void:
	var username: String = line_edit.text
	if len(username) < 5:
		error_text.text = "ERROR_USERNAME_1"
	_on_username_control_continue.emit(username)
