class_name CharterNodeTypeMenu
extends VBoxContainer

func _on_dropdown_button_pressed() -> void:
	$MenuBody.visible = not $MenuBody.visible
