extends PanelContainer
class_name Slot

@onready var texture_rect = $TextureRect
@onready var label = $debug  # Assuming you have a Label node as a child of Slot
@export_enum("NONE:0", "HEAD:1", "BODY:2", "LEG:3", "BOOTS:4", "ACTIVE:5") var slot_type: int

var filled: bool = false

func _get_drag_data(at_position):
	set_drag_preview(get_preview())
	return texture_rect

func _can_drop_data(_pos, data):
	return data is TextureRect

func _drop_data(_pos, data):
	# Swap properties between the current slot and the dragged slot
	var temp_property = texture_rect.property
	texture_rect.property = data.property
	data.property = temp_property

	update_label()

	# Update the filled status of the slots
	filled = texture_rect.property["TEXTURE"] != null
	data.get_parent().filled = data.property["TEXTURE"] != null

	# Update the label of the slot where the item was dragged from
	data.get_parent().update_label()

func get_preview():
	var preview_texture = TextureRect.new()
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(60, 60)
	preview_texture.set_z_index(1)
	var preview = Control.new()
	preview.add_child(preview_texture)
	return preview

func get_ATK():
	return texture_rect.property["ATK"]

func set_property(data):
	texture_rect.property = data
	update_label()

	filled = data["TEXTURE"] != null

func update_label():
	if texture_rect.property["TEXTURE"] == null:
		label.text = ""
	else:
		label.text = str(texture_rect.property["ATK"])
