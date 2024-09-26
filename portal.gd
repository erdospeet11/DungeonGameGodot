extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@export var location : PackedScene

var rainbow_outline_shader = preload("res://rainbow_outline.gdshader")
var is_inside_area = false

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("use") and is_inside_area:
		get_tree().change_scene_to_packed(location)

func _on_body_entered(body: Node2D) -> void:
	apply_rainbow_shader()
	is_inside_area = true

func _on_body_exited(body: Node2D) -> void:
	remove_rainbow_shader()
	is_inside_area = false

func apply_rainbow_shader() -> void:
	sprite_2d.material = ShaderMaterial.new()
	sprite_2d.material.shader = rainbow_outline_shader

func remove_rainbow_shader() -> void:
	sprite_2d.material = null
