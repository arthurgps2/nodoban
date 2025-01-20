extends Control

const node_type_menu_scene : PackedScene = preload("res://Charter/Node Type Menu/CharterNodeTypeMenu.tscn")

func _ready() -> void:
	%OptionsMenuButton.get_popup().index_pressed.connect(_on_options_menu_index_pressed)

func _on_options_menu_index_pressed(index : int):
	match index:
		0: # Save file
			$FileDialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
			$FileDialog.show()
		1: # Load file
			$FileDialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
			$FileDialog.show()
		2: # Node types
			$NodeTypes.show()

func _on_node_types_close_requested() -> void:
	$NodeTypes.hide()

func _on_new_node_button_pressed() -> void:
	var node_type_menu = node_type_menu_scene.instantiate()
	%NodeTypeContainer.add_child(node_type_menu)
	%NodeTypeContainer.move_child(node_type_menu, -1)
	%NodeTypeContainer.move_child(%NodeTypeContainer/NewNodeButton, -1)
