class_name CharterNodeTypeMenu
extends PanelContainer

const node_property_scene : PackedScene = preload("res://Charter/Node Type Menu/Node Property/CharterNodeProperty.tscn")

func _on_dropdown_button_pressed() -> void:
	%MenuBody.visible = not %MenuBody.visible

func _on_new_button_pressed() -> void:
	var node_property := node_property_scene.instantiate()
	%MenuBody/Items.add_child(node_property)
	%MenuBody/Items.move_child(node_property, -1)
	%MenuBody/Items.move_child(%MenuBody/Items/NewButton, -1)

func _on_delete_button_pressed() -> void:
	queue_free()
