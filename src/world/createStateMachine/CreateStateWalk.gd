extends "res://src/world/createStateMachine/CreatureStateBase.gd"

@export var walk_speed: float = 75.0

var destination_position: Vector2 = Vector2.ZERO
var has_point: bool = false


func _sort_walkable_polygon() -> Array:
	var points:Array[Vector2] = []
	for it in state_machine.walkable_area.polygon:
		points.append(it)
	points.sort_custom(func(a: Vector2, b: Vector2) -> bool:
		return a.length_squared() < b.length_squared()
	)
	return points


func _create_rnd_pos_on_walkable_area(polygon_points:Array[Vector2]) -> Vector2:
	var rnd_pos = Vector2.ZERO
	var closest = polygon_points[0]
	var fourthest = polygon_points[-1]
	while true:
		rnd_pos = Vector2(randf_range(closest.x,fourthest.x),randf_range(closest.y, fourthest.y))
		if Geometry2D.is_point_in_polygon(rnd_pos, state_machine.walkable_area.polygon) == true:
			break
	return rnd_pos
	


func _on_state_change_in():
	var walkable_area: Polygon2D = state_machine.walkable_area
	if walkable_area != null:
		var polygon_points = _sort_walkable_polygon()
		destination_position = _create_rnd_pos_on_walkable_area(polygon_points)
		has_point = true
		var rig_side:RigBase = state_machine.rigs[CreatureStateMachine.ERigs.SIDE]
		if rig_side != null:
			rig_side.visible = true
		else:
			push_error("ERROR: No front rig assinged to the statemachine")
	else:
		push_error("ERROR: No walkable area set in create or/and statemachine")
	

func _on_state_change_out():
	var rig_side:RigBase = state_machine.rigs[CreatureStateMachine.ERigs.SIDE]
	if rig_side != null:
		rig_side.visible = false
	else:
		push_error("ERROR: No front rig assinged to the statemachine")


func process_state(_delta: float):
	if has_point == true:
		var current_global_pos = state_machine.creature.global_position
		var dir = current_global_pos.direction_to(destination_position)
		state_machine.creature.global_position += dir * _delta * walk_speed
		var rig_side:RigBase = state_machine.rigs[CreatureStateMachine.ERigs.SIDE]
		if rig_side != null:
			rig_side.play_animation(RigBase.EAnimations.WALK_SLOW)
			rig_side.flip_x_axis(dir.x < 0)
		else:
			push_error("ERROR: No front rig assinged to the statemachine")
		if abs(current_global_pos.distance_to(destination_position)) < 10:
			state_machine.switch_to_state("idle")
		
