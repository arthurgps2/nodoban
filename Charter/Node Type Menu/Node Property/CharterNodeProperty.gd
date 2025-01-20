class_name CharterNodeProperty
extends PanelContainer

func get_property_name() -> String:
	return %PropertyName.text

func get_property_value() -> Variant:
	return %PropertyValue.get_value()
