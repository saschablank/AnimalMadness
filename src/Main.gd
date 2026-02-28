class_name MainScene extends Node2D

static var PLAYER_PROFILE: PlayerProfile = null
@onready var root_submenu: Control = $MainUi/RootSubmenu

var play_intro: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainUi/Boot.visible = true
	PLAYER_PROFILE = PlayerProfile.new()
	PLAYER_PROFILE._on_player_connected.connect(_on_player_connected)

func _start_up():
	$MainUi/Boot.visible = false
	$MainUi/Boot.queue_free()
	if PlayerProfile.FIRST_LOGIN == true:
		var set_name_submenu:SetDisplayNameControl = load_submenu("res://src/ui/SetDisplayNameControl.gd")
		set_name_submenu._on_username_control_continue.connect(_set_username_after_first_login_done)
	else:
		load_submenu("res://scenes/menu/LoadingScreen.tscn")
		PLAYER_PROFILE.do_nakama_login()


func _on_player_connected():
	if PlayerProfile.IS_ONLINE == true:
		PLAYER_PROFILE.load_item_storage_from_nakama()
		_on_load_world("res://scenes/levels/World0.tscn")
		close_submenu()
		
	else:
		print("NO NAKAMA CONNECTION POSSIBLE SHUTTING DOWN ....")
		get_tree().quit(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if play_intro == true:
		play_intro = false
		$MainUi/Boot.start_intro()
		await $MainUi/Boot._on_intro_done
		_start_up()


func load_submenu(scene_path:String):
	var new_scene = load(scene_path).instantiate()
	root_submenu.add_child(new_scene)
	root_submenu.visible = true
	return new_scene


func close_submenu():
	root_submenu.visible = false
	for it:Control in root_submenu.get_children():
		it.queue_free()


func _set_username_after_first_login_done(new_username: String):
	close_submenu()
	load_submenu("res://scenes/menu/LoadingScreen.tscn")
	PLAYER_PROFILE.temp_name_at_fist_startup = new_username
	PLAYER_PROFILE.do_nakama_login()


func _on_load_world(world_path: String) -> void:
	var world_to_load: WorldContainer = load(world_path).instantiate()
	if world_to_load != null:
		$WorldRoot.add_child(world_to_load)
