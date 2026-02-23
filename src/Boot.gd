extends Control
signal _on_intro_done()

@export var bgs_to_show: Array[String] = [
	"res://assets/branding/hühühü_slim.png",
	"res://assets/branding/MimirBytes.png"
]

var bg_index = 0

func _ready() -> void:
	# Optional: Sprache initial setzen (Fallback/Options später)
	# TranslationServer.set_locale("en")
	$Logo.texture = load(bgs_to_show[0])
	$Timer.timeout.connect(_go_next)

func start_intro():
	$Timer.start()


func _go_next() -> void:
	bg_index += 1
	if bg_index == len(bgs_to_show):
		_on_intro_done.emit()
	else:
		$Logo.texture = load(bgs_to_show[bg_index])

func _process(_delta: float) -> void:
	if Input.is_action_just_released("ui_text_clear_carets_and_selection"):
		_go_next()
