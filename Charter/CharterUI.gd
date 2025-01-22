class_name CharterUI
extends Control

enum OPTIONS_ITEM_ID {
	SAVE_FILE = 0,
	LOAD_FILE = 1,
	NODE_TYPES = 2,
}

const node_type_menu_scene : PackedScene = preload("res://Charter/NodeTypeMenu/CharterNodeTypeMenu.tscn")

func add_new_node_type() -> CharterNodeTypeMenu:
	var node_type_menu = node_type_menu_scene.instantiate()
	ChartInfo.add_node_type(node_type_menu)
	%NodeTypeContainer.add_child(node_type_menu)
	%NodeTypeContainer.move_child(node_type_menu, -1)
	%NodeTypeContainer.move_child(%NodeTypeContainer/NewNodeButton, -1)
	
	return node_type_menu

func get_node_type_names() -> Array:
	var types := []
	for child in %NodeTypeContainer.get_children():
		if child is not CharterNodeTypeMenu: continue
		types.append(child.get_node_type_name())
	
	return types

func clear_node_types() -> void:
	for child in %NodeTypeContainer.get_children():
		if child is CharterNodeTypeMenu: child.queue_free()

func _ready() -> void:
	%OptionsMenuButton.get_popup().index_pressed.connect(_on_options_menu_index_pressed)

func _on_options_menu_index_pressed(index : int):
	match index:
		OPTIONS_ITEM_ID.SAVE_FILE: # Save file
			$FileDialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
			$FileDialog.show()
		OPTIONS_ITEM_ID.LOAD_FILE: # Load file
			$FileDialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
			$FileDialog.show()
		OPTIONS_ITEM_ID.NODE_TYPES: # Node types
			$NodeTypes.show()

func _on_node_types_close_requested() -> void:
	$NodeTypes.hide()

func _on_new_node_button_pressed() -> void:
	add_new_node_type()

func _on_file_dialog_file_selected(path: String) -> void:
	match $FileDialog.file_mode:
		FileDialog.FILE_MODE_SAVE_FILE: ChartInfo.save_to_file(path)
		FileDialog.FILE_MODE_OPEN_FILE: ChartInfo.load_from_file(path)
