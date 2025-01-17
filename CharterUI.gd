extends Control

var node_scene := preload("res://CharterNode.tscn")

@onready var empty_menu := $EmptyRMBClickContextMenu

func _process(_delta: float) -> void:
	# Right click
	if Input.is_action_just_pressed("right_click"):
		if false: # Replace with a code to check if mouse is on node or link later
			pass
		else:
			# Dsplay "empty click" menu
			empty_menu.position = get_global_mouse_position()
			empty_menu.visible = true


func _on_empty_menu_index_pressed(index: int) -> void:
	match index:
		0:
			var node := node_scene.instantiate()
			node.position = get_local_mouse_position()
			get_node("../NodeView").add_child(node)
