extends Control

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
