class_name AttributteDisplay extends Panel

@export var attribute_name: String
@onready var label: Label = $AttributteDisplay/Label
@onready var texture_progress_bar: TextureProgressBar = $AttributteDisplay/TextureProgressBar

func _ready():
	label.text = attribute_name

func set_new_value(new_value: float):
	texture_progress_bar.value = new_value
