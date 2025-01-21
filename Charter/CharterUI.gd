class_name CharterUI
extends Control

enum OPTIONS_ITEM_ID {
	SAVE_FILE = 0,
	LOAD_FILE = 1,
	NODE_TYPES = 2,
}

const node_type_menu_scene : PackedScene = preload("res://Charter/NodeTypeMenu/CharterNodeTypeMenu.tscn")

func save_file(path : String) -> void:
	var chart := {
		node_types = {},
		nodes = [],
		links = [],
	}
	
	# Node types
	for child in %NodeTypeContainer.get_children():
		if child is not CharterNodeTypeMenu: continue
		chart.node_types[child.get_node_type_name()] = child.get_node_type_properties()
	
	# Convert to JSON
	var chart_json := JSON.stringify(chart)
	print(chart_json)

func load_file(path : String) -> void:
	pass

func get_node_type_names() -> Array:
	var types := []
	for child in %NodeTypeContainer.get_children():
		if child is not CharterNodeTypeMenu: continue
		types.append(child.get_node_type_name())
	
	return types

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
	var node_type_menu = node_type_menu_scene.instantiate()
	%NodeTypeContainer.add_child(node_type_menu)
	%NodeTypeContainer.move_child(node_type_menu, -1)
	%NodeTypeContainer.move_child(%NodeTypeContainer/NewNodeButton, -1)

func _on_file_dialog_file_selected(path: String) -> void:
	match $FileDialog.file_mode:
		FileDialog.FILE_MODE_SAVE_FILE: save_file(path)
		FileDialog.FILE_MODE_OPEN_FILE: load_file(path)
