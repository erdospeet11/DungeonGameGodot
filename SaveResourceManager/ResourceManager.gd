extends Node

const PLAYER_RESOURCE_PATH = "user://SaveResourceManager/PlayerResource.tres"
const INVENTORY_RESOURCE_PATH = "user://SaveResourceManager/InventoryResource.tres"

var player_resource: Resource
var inventory_resource: Resource

func _ready():
	load_resources()

func load_resources():
	player_resource = load_resource(PLAYER_RESOURCE_PATH)
	inventory_resource = load_resource(INVENTORY_RESOURCE_PATH)

func save_resources():
	save_resource(player_resource, PLAYER_RESOURCE_PATH)
	save_resource(inventory_resource, INVENTORY_RESOURCE_PATH)

func load_resource(path: String) -> Resource:
	if ResourceLoader.exists(path):
		return ResourceLoader.load(path)
	else:
		# Create a new resource if it doesn't exist
		var new_resource = Resource.new()
		save_resource(new_resource, path)
		return new_resource

func save_resource(resource: Resource, path: String):
	var error = ResourceSaver.save(resource, path)
	if error != OK:
		print("Failed to save resource to %s" % path)

# Example functions to update and retrieve data
func update_player_data(key: String, value):
	if player_resource:
		player_resource.set(key, value)

func get_player_data(key: String):
	return player_resource.get(key) if player_resource else null

func update_inventory_data(key: String, value):
	if inventory_resource:
		inventory_resource.set(key, value)

func get_inventory_data(key: String):
	return inventory_resource.get(key) if inventory_resource else null
