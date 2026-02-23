extends Control

signal _on_load_world(world_path: String)

var has_continue: bool = false # TODO: später aus SaveSystem holen

func _ready() -> void:
	$MarginContainer/VBox/BtnContinue.visible = has_continue
	if has_continue:
		$MarginContainer/VBox/BtnContinue.grab_focus()
	else:
		$MarginContainer/VBox/BtnStartWorld.grab_focus()


func _on_start_world_pressed() -> void:
	_on_load_world.emit("res://scenes/levels/World0.tscn")

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

func _on_btn_continue_pressed() -> void:
	pass # Replace with function body.
