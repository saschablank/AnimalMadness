class_name MainMenuControl extends Control

signal _on_load_world(world_path: String)
signal _on_set_username_at_first_startup_done(new_username: String)
@onready var root_submenu: Control = $RootSubmenu
@onready var btn_continue: Button = $MainPanel/MenuPanel/VBox/BtnContinue
@onready var btn_start_world: Button = $MainPanel/MenuPanel/VBox/BtnStartWorld
@onready var menu_panel: Panel = $MainPanel/MenuPanel
@onready var main_panel: Panel = $MainPanel



var has_continue: bool = false # TODO: später aus SaveSystem holen

func _ready() -> void:
	root_submenu.visible = false
	btn_continue.visible = has_continue
	if has_continue:
		btn_continue.grab_focus()
	else:
		btn_start_world.grab_focus()

func load_submenu(scene_path:String):
	var new_scene = load(scene_path).instantiate()
	root_submenu.add_child(new_scene)
	main_panel.visible = false
	root_submenu.visible = true
	return new_scene
	

func close_submenu():
	main_panel.visible = true
	root_submenu.visible = false
	for it:Control in root_submenu.get_children():
		it.queue_free()

func _show_set_usernamescreen():
	var set_display_name_control:SetDisplayNameControl = load_submenu("res://scenes/menu/SetDisplayName.tscn")
	set_display_name_control._on_username_control_continue.connect(_on_username_set_at_first_startup)
	
func _on_username_set_at_first_startup(new_user_name:String):
	_on_set_username_at_first_startup_done.emit(new_user_name)
	close_submenu()

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
