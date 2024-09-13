extends Node2D

# Reference to the Label node
@onready var label = $Label

# Method to set the label text
func set_label_text(text: String) -> void:
	label.text = text
	
func _get_direction():
	return Vector2(randf_range(-1,1), -randf()) * 16
