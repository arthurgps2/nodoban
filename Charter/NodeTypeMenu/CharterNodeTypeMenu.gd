class_name CharterNodeTypeMenu
extends PanelContainer

const property_scene : PackedScene = preload("res://Property/CharterProperty.tscn")

func get_node_type_name() -> String:
	return %NodeTypeNameEdit.text

func get_node_type_properties() -> Dictionary:
	var properties := {}
	
	for child in %MenuBody/Items.get_children():
		if child is not CharterProperty: continue
		properties[child.get_property_name()] = child.get_property_value()
	
	return properties

func _on_dropdown_button_pressed() -> void:
	%MenuBody.visible = not %MenuBody.visible

func _on_new_button_pressed() -> void:
	var node_property := property_scene.instantiate()
	%MenuBody/Items.add_child(node_property)
	%MenuBody/Items.move_child(node_property, -1)
	%MenuBody/Items.move_child(%MenuBody/Items/NewButton, -1)

func _on_delete_button_pressed() -> void:
	ChartInfo.remove_node_type(self)
	queue_free()
