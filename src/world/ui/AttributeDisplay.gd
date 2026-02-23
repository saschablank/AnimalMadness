class_name AttributteDisplay extends VBoxContainer

@export var attribute_name: String

func _ready():
	$Label.text = attribute_name

func set_new_value(new_value: float):
	$TextureProgressBar.value = new_value
