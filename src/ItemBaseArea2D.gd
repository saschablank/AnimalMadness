extends Area2D

var is_mouse_over: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_released("click") and $AnimationPlayer.is_playing() == false:
		$AnimationPlayer.play("click")
		


func _on_mouse_entered() -> void:
	is_mouse_over = true
	
