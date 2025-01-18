extends Control

func _ready() -> void:
	%OptionsMenuButton.get_popup().index_pressed.connect(_on_options_menu_index_pressed)

func _on_options_menu_index_pressed(index : int):
	match index:
		0: # Save file
			$FileDialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
			$FileDialog.visible = true
		1: # Load file
			$FileDialog.file_mode = FileDialog.FILE_MODE_OPEN_FILE
			$FileDialog.visible = true
		2: # Node types
			print("open node types")
