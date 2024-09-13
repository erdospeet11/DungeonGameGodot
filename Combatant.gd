extends Node2D
class_name Combatant

var attack_damage: int
var health: int
var combatant_name: String
var sprite_texture: String

var sprite: Sprite2D

#@onready var text_edit: TextEdit = get_parent().get_parent().get_node("UI/VBoxContainer/TextEdit")

func _init(name: String, health_value: int, attack_damage_value : int, texture: String):
	combatant_name = name
	health = health_value
	attack_damage = attack_damage_value
	sprite_texture = texture
	
	sprite = Sprite2D.new()
	add_child(sprite)
	sprite.texture = load(texture)

# Method to apply damage
func take_damage(damage: int) -> bool:
	var log = combatant_name + " took " + str(damage) + " damage from " + get_parent().name + "."
	#text_edit.text += log + "\n"
	health -= damage
	return health <= 0
