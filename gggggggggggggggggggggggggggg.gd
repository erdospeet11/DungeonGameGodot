extends Button

func _on_toggled(toggled_on: bool) -> void:
	print("toggled")
	print(self.button_pressed)
	if button_pressed:
		release_focus()
