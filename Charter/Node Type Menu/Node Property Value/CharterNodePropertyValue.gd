class_name CharterNodePropertyValue
extends HBoxContainer

enum ITEM_ID {
	STRING = 0,
	NUMBER = 1,
	BOOL = 2,
	ARRAY = 3,
}

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
				if child is not CharterNodePropertyValue: continue
				return_value.append(child.get_value())
			return return_value
			
		_: return null

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
