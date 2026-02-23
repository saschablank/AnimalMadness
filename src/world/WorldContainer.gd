class_name WorldContainer extends Node2D

@onready var creature: Creature = $Creature
@onready var walkable_area: Polygon2D = $walkableArea


func _ready():
	creature.walkable_area = walkable_area
