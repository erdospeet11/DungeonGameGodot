extends Node2D

# Combantant positions for the battle
@onready var marker_2d = $Team1/Marker2D
@onready var marker_2d_2 = $Team2/Marker2D2
@onready var marker_2d_3 = $Team1/Marker2D3
@onready var marker_2d_4 = $Team2/Marker2D4
@onready var marker_2d_5 = $Team2/Marker2D5
@onready var marker_2d_6 = $Team1/Marker2D6

# UI for the battle scene
@onready var canvas_layer: CanvasLayer = $ResultLayer
@onready var result : Label = $ResultLayer/Panel/Label

@onready var team1: Node2D = $Team1
@onready var team2: Node2D = $Team2

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	create_combatant(10, 3, "res://damagepopup/soldier3.tscn", "Combatant A", "res://icon.svg", marker_2d)
	create_combatant(10, 4, "res://damagepopup/soldier3.tscn", "Combatant B", "res://icon.svg", marker_2d_2)
	create_combatant(10, 5, "res://damagepopup/soldier3.tscn", "Combatant C", "res://icon.svg", marker_2d_3)
	create_combatant(10, 4, "res://damagepopup/soldier3.tscn", "Combatant D", "res://icon.svg", marker_2d_4)
	create_combatant(10, 3, "res://damagepopup/soldier3.tscn", "Combatant E", "res://icon.svg", marker_2d_5)
	create_combatant(10, 2, "res://damagepopup/soldier3.tscn", "Combatant F", "res://icon.svg", marker_2d_6)

	start_combat()

func start_combat():
	while team1.get_child_count() > 0 and team2.get_child_count() > 0:
		# Team 1 attacks Team 2
		if team1.get_child_count() > 0:
			var attacker1 = get_random_combatant(team1)
			if attacker1 and team2.get_child_count() > 0:
				var defender1 = get_random_combatant(team2)
				if defender1 and defender1.take_damage(attacker1.attack_damage):
					defender1.get_parent().get_parent().remove_child(defender1.get_parent())
					defender1.get_parent().queue_free()
		await get_tree().create_timer(1).timeout

		# Check if Team 2 is defeated
		if team2.get_child_count() == 0:
			break

		# Team 2 attacks Team 1
		if team2.get_child_count() > 0:
			var attacker2 = get_random_combatant(team2)
			if attacker2 and team1.get_child_count() > 0:
				var defender2 = get_random_combatant(team1)
				if defender2 and defender2.take_damage(attacker2.attack_damage):
					defender2.get_parent().get_parent().remove_child(defender2.get_parent())
					defender2.get_parent().queue_free()
		await get_tree().create_timer(1).timeout

		# Check if Team 1 is defeated
		if team1.get_child_count() == 0:
			break

	print("Combat Ended")
	if team1.get_child_count() > 0:
		result.set_text("The winner is Team 1.")
		canvas_layer.visible = !canvas_layer.visible
		print("Team 1 Wins!")
	else:
		result.set_text("The winner is Team 2.")
		canvas_layer.visible = !canvas_layer.visible
		print("Team 2 Wins!")

func get_random_combatant(team: Node2D) -> Node2D:
	var count = team.get_child_count()
	if count == 0:
		return null
	var random_index = rng.randi_range(0, count - 1)
	var marker = team.get_child(random_index)
	if marker.get_child_count() > 0:
		return marker.get_child(0)
	return null

func create_combatant(combatant_health, combatant_damage, combatant_scene, combatant_name, combatant_sprite_path, marker):
	var custom_node_scene = load(combatant_scene)
	var custom_node = custom_node_scene.instantiate()
	
	print((custom_node is Soldier))
	
	custom_node.get_node("SpritePreview").texture = load(combatant_sprite_path)
	custom_node.get_node("CombatantName").text = combatant_name
	custom_node.health = combatant_health
	custom_node.attack_damage = combatant_damage
	
	var textt = "Health: " + str(combatant_health) + ", Attack: " + str(combatant_damage)
	custom_node.get_node("SpritePreview/TextureRect").set_tooltip_text(textt)
	
	marker.add_child(custom_node)
