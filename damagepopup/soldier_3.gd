extends Node2D
class_name Soldier

var attack_damage : int
var health : int

@onready var text_edit = get_parent().get_parent().get_parent().get_node("CanvasLayer/VBoxContainer/TextEdit")

func take_damage(damage: int) -> bool:
	var log = $CombatantName.text + " from " + get_parent().get_parent().name + " took " + str(damage) + " damage."
	text_edit.text += log + "\n"
	health -= damage
	$ProgressBar.value -= damage
	
	var custom_node_scene = load("res://damagepopup/damage_popup.tscn")
	var custom_node = custom_node_scene.instantiate()
	custom_node.position = self.position
	add_child(custom_node)
	custom_node.set_label_text("-" + str(damage))
	
	return health <= 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$ProgressBar.max_value = health
	print("I entered the scene")
