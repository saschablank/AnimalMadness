class_name UtilStatics
extends Object


static func serialize_object(data_object: Object, property_ignore_list: Array = []) -> Dictionary:
	var data: Dictionary = {}
	for it in data_object.get_property_list():
		if it["name"] != "script" and it["name"].contains(".gd") == false and it["name"] not in property_ignore_list and it["name"] != "RefCounted":
			if it["type"] == TYPE_COLOR:
				data[it["name"]] = data_object.get(it["name"]).to_html()
			else:
				data[it["name"]] = data_object.get(it["name"])
	return data


static func desirialize_object(data_object: Object, data: Dictionary) -> Object:
	var special_properties: Dictionary = {}
	for it in data_object.get_property_list():
		if it["name"] != "script" and it["name"].contains(".gd") == false:
			if it["type"] == TYPE_COLOR:
				special_properties[it["name"]] = TYPE_COLOR
	for it in data:
		if it in special_properties.keys():
			if special_properties[it] == TYPE_COLOR:
				var color = Color.html(data[it])
				data_object.set(it, color)
		else:
			data_object.set(it, data[it])
	return data_object


static func get_is_pc():
	return OS.get_name() != "Android" and OS.has_feature("web_android") == false and OS.has_feature("web_ios") == false


static func is_browser():
	return OS.get_name() == "Web" or OS.has_feature("web_android") or OS.has_feature("web_ios")
