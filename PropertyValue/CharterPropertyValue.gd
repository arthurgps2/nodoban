class_name CharterPropertyValue
extends HBoxContainer

enum ITEM_ID {
	STRING = 0,
	NUMBER = 1,
	BOOL = 2,
	ARRAY = 3,
}

const property_value_scene : PackedScene = preload("res://PropertyValue/CharterPropertyValue.tscn")

func get_value() -> Variant:
	match %ValueType.selected:
		ITEM_ID.STRING:
			return %StringEdit.text
		ITEM_ID.NUMBER:
			var num_str : String = %NumberEdit.text
			if num_str.is_valid_int(): return num_str.to_int()
			elif num_str.is_valid_float(): return num_str.to_float()
			else: return null
		ITEM_ID.BOOL:
			return %BoolEdit.button_pressed
		ITEM_ID.ARRAY:
			var return_value := []
			for child in %ArrayEdit.get_children():
				if child is not CharterPropertyValue: continue
				return_value.append(child.get_value())
			return return_value
			
		_: return null

func set_value(value : Variant) -> void:
	match typeof(value):
		TYPE_STRING:
			%ValueType.selected = ITEM_ID.STRING
			%StringEdit.text = value
		TYPE_INT, TYPE_FLOAT:
			%ValueType.selected = ITEM_ID.NUMBER
			%NumberEdit.text = str(value)
		TYPE_BOOL:
			%ValueType.selected = ITEM_ID.BOOL
			%BoolEdit.button_pressed = value
		TYPE_ARRAY:
			%ValueType.selected = ITEM_ID.ARRAY
			for item in value:
				var array_item = add_array_item()
				array_item.set_value(item)
	
	%ValueType.item_selected.emit(%ValueType.selected)

func add_array_item() -> CharterProperty:
	var node_property_value := property_value_scene.instantiate()
	node_property_value.get_node("%DeleteButton").pressed.connect(node_property_value._on_delete_button_pressed)
	%ArrayEdit.add_child(node_property_value)
	%ArrayEdit.move_child(node_property_value, -1)
	%ArrayEdit.move_child(%ArrayEdit/NewArrayItemButton, -1)
	
	return node_property_value

func _on_value_type_item_selected(index: int) -> void:
	%StringEdit.visible = false
	%NumberEdit.visible = false
	%BoolEdit.visible = false
	%ArrayEdit.visible = false
	
	match index:
		ITEM_ID.STRING:
			%StringEdit.visible = true
		ITEM_ID.NUMBER:
			%NumberEdit.visible = true
		ITEM_ID.BOOL:
			%BoolEdit.visible = true
		ITEM_ID.ARRAY:
			%ArrayEdit.visible = true

func _on_new_array_item_button_pressed() -> void:
	add_array_item()

func _on_delete_button_pressed() -> void:
	queue_free()
