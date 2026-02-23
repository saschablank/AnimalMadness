class_name NakamaWebClient extends Node

signal _on_auth_done(nakama_session: NakamaSession)

const DO_CREATE_ACCOUNT:bool = true

static var STORAGE_PERMISSION_PRIVATE = 1
static var STORAGE_PERMISSION_PUBLIC = 2

var nakama_client: NakamaClient = null
var nakama_session: NakamaSession = null
const NAKAMA_SERVER_ADDRESS = "13.60.189.32"
const NAKAMA_SERVER_PORT = 7350
const NAKAMA_WEB_PROTOKOL = "http"
const NAKAMA_SERVER_KEY = "climber"


func _init() -> void:
	nakama_client = Nakama.create_client(NAKAMA_SERVER_KEY,
		NAKAMA_SERVER_ADDRESS, NAKAMA_SERVER_PORT, 
		NAKAMA_WEB_PROTOKOL)


func create_random_string_64() -> String:
	var charset := "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
	var out := ""
	var max_index := charset.length() - 1
	for i in 64:
		out += charset[randi() % max_index]
	return out


func first_time_connect_to_nakama(p_device_id: String) -> NakamaSession:
	var device_id = p_device_id
	#if GameStatics.FAKE_DEVICE_ID != null:
		#device_id = GameStatics.FAKE_DEVICE_ID
	if nakama_client != null:
		for it in range(0,3):
			nakama_session = await nakama_client.authenticate_device_async(device_id, null, DO_CREATE_ACCOUNT)
			if nakama_session.is_exception():
				push_error("An error occurred: %s" % nakama_session)
			else:
				await nakama_client.rpc_async(nakama_session, "setupWallet")
				await nakama_client.rpc_async(nakama_session, "setupPlayerInventory")
				return nakama_session
	return nakama_session


func login_without_session_id(user_name: String, p_device_id: String) -> NakamaSession:
	var device_id = p_device_id
	nakama_session = await nakama_client.authenticate_device_async(device_id, user_name)
	if nakama_session.is_exception():
		push_error("An error occurred: %s" % nakama_session)
		_on_auth_done.emit(null)
		return
	if nakama_session.is_valid():
		return nakama_session
	return null


func is_nakama_alive(_url: String, _parent_node: Control) -> bool:
	return true


func login_with(session_token: String, user_id: String, p_device_id: String) -> NakamaSession:
	var device_id = p_device_id
	var session_to_validate: NakamaSession = NakamaClient.restore_session(session_token)
	if session_to_validate.expired == true:
		session_to_validate = await nakama_client.session_refresh_async(session_to_validate)
		if session_to_validate.is_exception():
			session_to_validate = await nakama_client.authenticate_device_async(device_id, user_id)
			if session_to_validate.is_exception() == true:
				push_error(session_to_validate.get_exception())
				return null
			nakama_session = session_to_validate
			return nakama_session
		else:
			nakama_session = session_to_validate
			return nakama_session
	else:
		nakama_session = session_to_validate
		return nakama_session


func request_account_data():
	if nakama_session.is_valid():
		var account_data: NakamaAPI.ApiAccount = await nakama_client.get_account_async(nakama_session)
		if account_data.is_exception() == true:
			push_error("Error: Reciving Accountdata: %s"  % account_data)
			return
		return account_data
	return null


func update_account(account_data: NakamaAccountData) -> bool:
	if nakama_session.is_valid():
		var response = await nakama_client.update_account_async(nakama_session, null, account_data.display_name, account_data.avatar_url)
		if response.is_exception():
			push_error(response.get_exception().message)
			return false
		return true
	push_error("Error: no valid nakama session")
	return false
