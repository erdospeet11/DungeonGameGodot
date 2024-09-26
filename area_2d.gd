extends Area2D

var entered = false

func _on_body_entered(body: Node2D) -> void:
	entered = true


func _on_body_exited(body: Node2D) -> void:
	entered = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("use") and entered:
		get_tree().change_scene_to_file("res://WorldMap.tscn")
