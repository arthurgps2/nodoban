class_name CharterProperty
extends PanelContainer

func _ready() -> void:
	%PropertyValue.get_node("%DeleteButton").pressed.connect(_on_delete_button_pressed)

func get_property_name() -> String:
	return %PropertyName.text

func set_property_name(name : String) -> void:
	%PropertyName.text = name

func get_property_value() -> Variant:
	return %PropertyValue.get_value()

func set_property_value(value : Variant) -> void:
	%PropertyValue.set_value(value)

func _on_delete_button_pressed() -> void:
	queue_free()
