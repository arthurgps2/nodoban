class_name CharterNodePropertyValue
extends HBoxContainer

enum ITEM_ID {
	STRING = 0,
	NUMBER = 1,
	BOOL = 2,
	ARRAY = 3,
}


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
