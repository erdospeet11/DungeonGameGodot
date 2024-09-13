extends Node2D

@onready var kard = $Sprite2D

func _process(delta):
	rotate_towards_cursor()

func rotate_towards_cursor():
	var mouse_position = get_global_mouse_position()
	var angle_to_cursor = angle_to_point(mouse_position)
	rotation_degrees = deg_to_rad(angle_to_cursor)

func angle_to_point(point):
	var vector_to_point = point - global_position
	return atan2(vector_to_point.y, vector_to_point.x)
