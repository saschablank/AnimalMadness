extends Control

@export var back_scene: String = "res://scenes/menu/MainMenu.tscn"

# i18n Keys für die jeweilige Szene (Achievements oder Credits)
@export var title_key: String = "TITLE_ACHIEVEMENTS"
@export var body_key: String = "ACHIEVEMENTS_PLACEHOLDER"

func _ready() -> void:
	$MarginContainer/VBoxContainer/Title.text = tr(title_key)
	$MarginContainer/VBoxContainer/Body.text = tr(body_key)
	$MarginContainer/VBoxContainer/BtnBack.text = tr("MENU_BACK")
	$MarginContainer/VBoxContainer/BtnBack.grab_focus()

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file(back_scene)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		_on_back_pressed()
