class_name NakamaItemBase extends RefCounted


var id:String
var cost: int = -1
var name: String
var currency:String
var texture_parts: Array[String] = []
var icon_texture: String


func load_item_from_data(data:Dictionary):
	UtilStatics.desirialize_object(self,data)
	
func get_data_from_item():
	return UtilStatics.serialize_object(self)
