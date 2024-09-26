extends Node2D

@onready var tilemap_layer1: TileMapLayer = $GroundMapLayer
@onready var tilemap_layer2: TileMapLayer = $EnvironmentMapLayer

func check_cell_at_coordinate(coord: Vector2i) -> bool:
	# Check if there's a cell in layer1 but not in layer2
	var cell_in_layer1 = tilemap_layer1.get_cell_source_id(coord) != -1
	var cell_in_layer2 = tilemap_layer2.get_cell_source_id(coord) != -1
	
	return cell_in_layer1 and not cell_in_layer2

func _ready():
	# Example usage
	var coordinate_to_check = Vector2i(15, 51)
	if check_cell_at_coordinate(coordinate_to_check):
		print("There's a cell in layer1 but not in layer2 at ", coordinate_to_check)
	else:
		print("The condition is not met at ", coordinate_to_check)
