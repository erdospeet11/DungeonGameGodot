extends CanvasLayer

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("sheet"):
		visible = !visible

func _on_close_button_pressed() -> void:
	visible = !visible
