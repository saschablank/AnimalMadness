class_name PlayerProfile extends RefCounted

signal _on_player_connected()

static var FIRST_LOGIN:bool = false
static var IS_ONLINE:bool = false

var nakama_web_client: NakamaWebClient = null
var nakama_account_data: NakamaAccountData = null
var nakama_session_data: NakamaSessionData = null
var nakama_item_storage: NakamaItemStorage = null
var temp_name_at_fist_startup:String = ""

var display_name: String:
	get():
		return nakama_account_data.display_name
	set(new_display_name):
		nakama_account_data.display_name = new_display_name 
		nakama_account_data.write_data()
		
var avatar_path: String:
	get():
		return nakama_account_data.avatar_url
	set(new_path):
		nakama_account_data.avatar_url = new_path
		nakama_account_data.write_data()


func _init() -> void:
	nakama_web_client = NakamaWebClient.new()
	nakama_account_data = NakamaAccountData.new(nakama_web_client)
	nakama_session_data = NakamaSessionData.new(nakama_web_client)
	nakama_item_storage = NakamaItemStorage.new(nakama_web_client)
	nakama_session_data.load_from_file()
	if nakama_session_data.device_id.is_empty(): #first login
		PlayerProfile.FIRST_LOGIN = true


func _create_device_id():
	var r_device_id: String = OS.get_unique_id()
	if UtilStatics.is_browser() == true:
		r_device_id = nakama_web_client.create_random_string_64()
	return r_device_id


func do_nakama_login():
	if nakama_web_client == null:
		push_error("ERROR: No web client connected. Shuting down")
		PlayerProfile.IS_ONLINE = false
		_on_player_connected.emit()
	else:
		if PlayerProfile.FIRST_LOGIN == true and temp_name_at_fist_startup.is_empty() == false: #first login
			var device_id = _create_device_id()
			nakama_session_data.device_id = device_id
			var nakama_session:NakamaSession = (
				await nakama_web_client.first_time_connect_to_nakama(device_id)
			)
			if nakama_session != null:
				nakama_session_data.load_from_session(nakama_session)
				nakama_session_data.write_to_file()
				nakama_account_data.request_data_from_nakama()
				display_name = temp_name_at_fist_startup
				PlayerProfile.IS_ONLINE = true
				_on_player_connected.emit()
			else:
				push_error("ERROR: Cant connect to nakama")
				PlayerProfile.IS_ONLINE = false
				_on_player_connected.emit()
		else:
			var nakama_session:NakamaSession = await nakama_web_client.login_with(nakama_session_data.token,
										 nakama_session_data.user_id,
										 nakama_session_data.device_id)
			if nakama_session != null:
				PlayerProfile.IS_ONLINE = true
				nakama_session_data.load_from_session(nakama_session)
				nakama_session_data.write_to_file()
				nakama_account_data.request_data_from_nakama()
				_on_player_connected.emit()
			else:
				push_error("ERROR: Cant connect to nakama")
				PlayerProfile.IS_ONLINE = false
				_on_player_connected.emit()

func load_item_storage_from_nakama():
	var collections:Array[String] = ["items_walkable_area", "items_plant_area" ]
	nakama_item_storage.request_full_storage(collections)
	
