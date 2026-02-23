class_name NakamaSessionData
extends RefCounted


var user_id: String
var refresh_token: String
var token: String
var nakama_username: String = ""
var device_id: String
var galaxy_client: NakamaWebClient = null


func _init(p_galaxy_client: NakamaWebClient):
	galaxy_client = p_galaxy_client


func load_from_session(session: NakamaSession):
	token = session.token
	refresh_token = session.refresh_token
	user_id = session.user_id


func write_to_file():
	var path = "user://session.json"
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_string(JSON.stringify(UtilStatics.serialize_object(self)))


func load_from_file() -> bool:
	var succses: bool = false
	var path = "user://session.json"
	var file = FileAccess.open(path, FileAccess.READ)
	if file != null:
		var data:String = file.get_as_text()
		if data.is_empty() == false and data != "file_not_found":
			UtilStatics.desirialize_object(self, JSON.parse_string(data))
			succses = true
	return succses
