extends Sprite2D

@export var ID = "0"

func _ready():
	texture = load("res://fos inventory/item_image/" + ItemData.get_texture(ID))

func _on_body_entered(body):
	print(get_parent())
	get_parent().find_child("Inventory").add_item(ID)
	queue_free()
