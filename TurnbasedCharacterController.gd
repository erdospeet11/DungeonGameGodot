extends CharacterBody2D
class_name TurnBasedPlayerdd

@export_group("Player Attributes")
@export var health: int = 100
@export var attack_damage: int = 10
@export var attack_speed: float = 1.0

@onready var attributes_container = $CanvasLayer/AttributeContainer

var animation_speed = 3
var moving = false
var tile_size = 16
var inputs = {
	"right": Vector2.RIGHT,
	"left": Vector2.LEFT,
	"up": Vector2.UP,
	"down": Vector2.DOWN
}

@onready var ray = $RayCast2D
@onready var animator = $animatedsprite

var attributes = ["Health", "Attack Damage", "Attack Speed"]

func initialize_attributes():
	print(attributes_container.get_children())
	for child in attributes_container.get_children():
		if child is Label:
			child.text = attributes[child.get_index()]

func log_player_position_based_on_tile():
	var tilemap = get_parent().get_child(0)
	var tile_pos = tilemap.local_to_map(position)
	print("The player is tanding on tile: ", tile_pos)

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size / 2

	initialize_attributes()
	log_player_position_based_on_tile()

func _process(delta):
	if moving:
		return
	if Input.is_action_pressed("left"):
		animator.flip_h = true
		move("left")
	elif Input.is_action_pressed("right"):
		animator.flip_h = false
		move("right")
	elif Input.is_action_pressed("up"):
		move("up")
	elif Input.is_action_pressed("down"):
		move("down")

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	var raycast_result = ray.get_collider()
	if not ray.is_colliding() or raycast_result.is_in_group("Itemm"):
		var target_position = position + inputs[dir] * tile_size
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", target_position, 1.0 / animation_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		animator.play("walk")
		await tween.finished
		animator.stop()
		moving = false
