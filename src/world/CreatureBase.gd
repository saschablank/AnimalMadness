class_name Creature extends Node2D

@export var walkable_area: Polygon2D = null
var new_action_timer: Timer = Timer.new()
var dest_position:Vector2 = Vector2.ZERO

var state = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	new_action_timer.wait_time = 5.0
	new_action_timer.timeout.connect(_do_new_action)
	add_child(new_action_timer)
	new_action_timer.start()
	

func _do_new_action():
	print("DO NEW ACTION")
	var rnd_pos
	while true:
		rnd_pos = Vector2(randf_range(72,1850),randf_range(650,850))
		if Geometry2D.is_point_in_polygon(rnd_pos,walkable_area.polygon) == true:
			break
	dest_position = rnd_pos
	state = 1
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if state == 1:
		if abs(global_position.distance_to(dest_position)) < 5:
			state = 0
			if new_action_timer.is_stopped() == true:
				new_action_timer.start()
		else:
			global_position += global_position.direction_to(dest_position) * 100 * delta
			if new_action_timer.is_stopped() == false:
				new_action_timer.stop()
			
