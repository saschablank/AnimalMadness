class_name ItemBase extends RefCounted




@export var id: int = -1
@export var item_type:String = "none"
@export var item_name: String = "none"
@export var item_cost: int = -1
@export var item_icon_path: String = ""
@export var item_to_place_texture_path: String =  ""
@export var item_count = 1
@export var is_placeable: bool = false


static var item_id_to_name_map: Dictionary = {
	"simple_foodbowl": 0,
	"basic_food": 1,
	"water": 2,
	"coffee": 3,
	"tee" : 4
}


static func create_item(p_item_name: String, p_item_count: int = 1):
	var item: ItemBase = null
	if p_item_name == "simple_foodbowl":
		item = ItemBase.new()
		item.id = item_id_to_name_map[p_item_name]
		item.name = p_item_name
		item.item_cost = 20
		item.item_icon_path = "res://assets/items/icons/icon_simple_food_bowl.png"
		item.item_to_place_texture_path = "res://assets/items/simple_food_bowl.png"
		item.item_count = p_item_count
	if p_item_name == "basic_food":
		item = ItemBase.new()
		item.id = item_id_to_name_map[p_item_name]
		item.name = p_item_name
		item.item_cost = 5
		item.item_icon_path = "res://assets/items/basic_food.png" 
		item.item_icon_path = "res://assets/items/basic_food.png"
		item.item_to_place_texture_path = "res://assets/items/basic_food.png"
		item.item_count = p_item_count
	return item
