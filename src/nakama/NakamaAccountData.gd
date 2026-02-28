class_name NakamaAccountData extends RefCounted

var nakama_web_client: NakamaWebClient = null
var user_id: String = ""
var user_name = ""
var display_name: String = ""
var avatar_url: String = "res://assets/playeravatars/icon.svg"
var online: bool
var google_id: String = ""
var wallet: Dictionary = {}




func _init(p_nakama_web_client: NakamaWebClient):
	nakama_web_client = p_nakama_web_client


func request_data_from_nakama():
	var data = await nakama_web_client.request_account_data()
	if data != null:
		wallet = JSON.parse_string(data.wallet)	
		user_name = data.user.username
		avatar_url = data.user.avatar_url
		user_id = data.user.id
		display_name = data.user.display_name
		online = data.user.online
		google_id = data.user.google_id


func update_display_name(new_display_name: String):
	display_name = new_display_name


func write_data():
	nakama_web_client.update_account(self)
