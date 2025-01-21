class_name CharterProperty
extends PanelContainer

func _ready() -> void:
	%PropertyValue.get_node("%DeleteButton").pressed.connect(_on_delete_button_pressed)

func get_property_name() -> String:
	return %PropertyName.text

func get_property_value() -> Variant:
	return %PropertyValue.get_value()

func _on_delete_button_pressed() -> void:
	queue_free()
