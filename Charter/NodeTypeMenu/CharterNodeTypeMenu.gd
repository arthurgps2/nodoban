class_name CharterNodeTypeMenu
extends PanelContainer

const property_scene : PackedScene = preload("res://Property/CharterProperty.tscn")
const icon_dropdown_open : Texture2D = preload("res://Icons/ArrowDown.png")
const icon_dropdown_closed : Texture2D = preload("res://Icons/ArrowRight.png")

func add_new_property() -> CharterProperty:
	var node_property := property_scene.instantiate()
	%MenuBody/Items.add_child(node_property)
	%MenuBody/Items.move_child(node_property, -1)
	%MenuBody/Items.move_child(%MenuBody/Items/NewButton, -1)
	
	return node_property


func get_node_type_name() -> String:
	return %NodeTypeNameEdit.text

func set_node_type_name(name : String) -> void:
	%NodeTypeNameEdit.text = name

func get_node_type_properties() -> Dictionary:
	var properties := {}
	
	for child in %MenuBody/Items.get_children():
		if child is not CharterProperty: continue
		properties[child.get_property_name()] = child.get_property_value()
	
	return properties

func set_node_type_properties(properties : Dictionary) -> void:
	for property in properties:
		var charter_property := add_new_property()
		charter_property.set_property_name(property)
		charter_property.set_property_value(properties[property])

func _on_dropdown_button_pressed() -> void:
	%MenuBody.visible = not %MenuBody.visible
	if %MenuBody.visible: %DropdownButton.icon = icon_dropdown_open
	else: %DropdownButton.icon = icon_dropdown_closed

func _on_new_button_pressed() -> void:
	add_new_property()
	
func _on_delete_button_pressed() -> void:
	ChartInfo.remove_node_type(self)
	queue_free()
