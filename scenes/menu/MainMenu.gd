extends Control

var has_continue: bool = false # TODO: später aus SaveSystem holen

func _ready() -> void:
	_apply_i18n()
	_update_continue_visibility()

	# Fokus: wenn Continue da ist -> Continue, sonst Start World
	if has_continue:
		$MarginContainer/VBox/BtnContinue.grab_focus()
	else:
		$MarginContainer/VBox/BtnStartWorld.grab_focus()

func _apply_i18n() -> void:
	$MarginContainer/VBox/Title.text = tr("TITLE_MAIN")

	$MarginContainer/VBox/BtnContinue.text = tr("MENU_CONTINUE")
	$MarginContainer/VBox/BtnStartWorld.text = tr("MENU_START_WORLD")
	$MarginContainer/VBox/BtnLoadWorld.text = tr("MENU_LOAD_WORLD")
	$MarginContainer/VBox/BtnOptions.text = tr("MENU_OPTIONS")
	$MarginContainer/VBox/BtnAchievements.text = tr("MENU_ACHIEVEMENTS")
	$MarginContainer/VBox/BtnCredits.text = tr("MENU_CREDITS")
	$MarginContainer/VBox/BtnExit.text = tr("MENU_EXIT")

func _update_continue_visibility() -> void:
	$MarginContainer/VBox/BtnContinue.visible = has_continue

func _on_start_world_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world/WorldSelect.tscn")

func _on_load_world_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/SaveSlots.tscn")

func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/OptionsMenu.tscn")
	
func _on_achievements_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/AchievementsMenu.tscn")
	
func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menu/CreditsMenu.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()
