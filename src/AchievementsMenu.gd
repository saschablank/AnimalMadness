extends Control

func _ready() -> void:
	$MarginContainer/VBoxContainer/Title.text = tr("TITLE_ACHIEVEMENTS")
	$MarginContainer/VBoxContainer/Body.text = tr("ACHIEVEMENTS_PLACEHOLDER")
	$MarginContainer/VBoxContainer/BtnBack.text = tr("MENU_BACK")
	$MarginContainer/VBoxContainer/BtnBack.grab_focus()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/MainMenu.tscn")
