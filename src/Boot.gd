extends Control

@export var next_scene: String = "res://scenes/menu/MainMenu.tscn"

func _ready() -> void:
	# Optional: Sprache initial setzen (Fallback/Options später)
	# TranslationServer.set_locale("en")
	$Timer.timeout.connect(_go_next)

func _go_next() -> void:
	get_tree().change_scene_to_file(next_scene)
