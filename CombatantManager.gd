extends Node2D

# References to the teams
var team1: Node2D
var team2: Node2D
var rng: RandomNumberGenerator = RandomNumberGenerator.new()

@onready var canvas_layer: CanvasLayer = $ResultLayer
@onready var result : Label = $ResultLayer/Panel/Label

func _ready():
	team1 = $Team1
	team2 = $Team2
	
	create_combatant(team1, "Combatant A", 100, 20, "res://Basic Asset Pack/Basic Asset Pack/basic magical animations/corrupted treant/CorruptedTreant.png")
	create_combatant(team2, "Combatant B", 90, 25, "res://Basic Asset Pack/Basic Asset Pack/basic magical animations/corrupted treant/CorruptedTreant.png")
	
	start_combat()

func start_combat():
	while team1.get_child_count() > 0 and team2.get_child_count() > 0:
		# Team 1 attacks Team 2
		if team1.get_child_count() > 0:
			var attacker1 = get_random_combatant(team1)
			if team2.get_child_count() > 0:
				var defender1 = get_random_combatant(team2)
				if defender1.take_damage(attacker1.attack_damage):
					team2.remove_child(defender1)
					defender1.queue_free()
		await get_tree().create_timer(1).timeout
		
		# Check if Team 2 is defeated
		if team2.get_child_count() == 0:
			break
		
		# Team 2 attacks Team 1
		if team2.get_child_count() > 0:
			var attacker2 = get_random_combatant(team2)
			if team1.get_child_count() > 0:
				var defender2 = get_random_combatant(team1)
				if defender2.take_damage(attacker2.attack_damage):
					team1.remove_child(defender2)
					defender2.queue_free()
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
	var random_index = rng.randi_range(0, count - 1)
	return team.get_child(random_index)
	
func create_combatant(team: Node2D, name: String, health: int, attack_damage: int, sprite_texture: String):
	var combatant = Combatant.new(name, health, attack_damage, sprite_texture)
	team.add_child(combatant)
