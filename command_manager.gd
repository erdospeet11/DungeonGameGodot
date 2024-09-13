extends Panel

@onready var line_edit: LineEdit = $VBoxContainer/LineEdit
@onready var text_edit: TextEdit = $VBoxContainer/TextEdit

func _on_line_edit_text_submitted(new_text: String) -> void:
	# Print the submitted text (for debugging purposes)
	print("Submitted text: ", new_text)
	
	# Append the new text to the TextEdit
	text_edit.text += new_text + "\n"
	
	# Clear the LineEdit
	line_edit.clear()
