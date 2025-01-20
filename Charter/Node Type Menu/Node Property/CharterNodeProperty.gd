class_name CharterNodeProperty
extends PanelContainer

func get_property_name() -> String:
	return %PropertyName.text

func get_property_value() -> Variant:
	return %PropertyValue.get_value()

func _on_button_pressed() -> void:
	queue_free()
