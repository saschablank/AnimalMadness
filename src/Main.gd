extends Node2D

static var PLAYER_PROFILE: PlayerProfile = null

var play_intro: bool = true
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$MainUi/Boot.visible = true
	$MainUi/MainMenu.visible = false
	PLAYER_PROFILE = PlayerProfile.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if play_intro == true:
		play_intro = false
		$MainUi/Boot.start_intro()
		await $MainUi/Boot._on_intro_done
		$MainUi/Boot.visible = false
		$MainUi/Boot.queue_free()
		$MainUi/MainMenu.visible = true
		PLAYER_PROFILE.do_nakama_login()
		await PLAYER_PROFILE._on_player_connected
		print("PLAYER CONNECTED")
		print(PLAYER_PROFILE.IS_ONLINE)



func _on_main_menu__on_load_world(world_path: String) -> void:
	var world_to_load: WorldContainer = load(world_path).instantiate()
	if world_to_load != null:
		$MainUi.visible = false
		$WorldRoot.add_child(world_to_load)
