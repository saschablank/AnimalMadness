class_name NakamaItemStorage extends RefCounted

var nakama_admin_id:String = "00000000-0000-0000-0000-000000000000"
var nakama_web_client: NakamaWebClient = null
var nakama_items:Dictionary = {}


func _init(web_client: NakamaWebClient) -> void:
	nakama_web_client = web_client


func request_full_storage(collections_to_read: Array[String]):
	for it: String in collections_to_read:
		var data = await nakama_web_client.request_storage_data(it, nakama_admin_id)
		for item in data:
			var new_item_obj:NakamaItemBase = NakamaItemBase.new()
			new_item_obj.load_item_from_data(item)
			if it not in nakama_items.keys():
				nakama_items[it] = []
			nakama_items[it].append(new_item_obj)
	

func get_items_by_type(type):
	if type in nakama_items.keys():
		return nakama_items[type]
	push_error("NO ITEM TYPE WITH THAT NAME: " + type)
	return []


func get_item_by_id(item_id:String):
	for it in nakama_items.keys():
		for item:NakamaItemBase in nakama_items[it]:
			if item.id == item_id:
				return item
	return null
