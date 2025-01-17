extends Control

var node_dragging : CharterNode = null
var node_drag_offset : Vector2

func _process(delta: float) -> void:
	var mouse_pos := get_global_mouse_position()
	
	if Input.is_action_just_pressed("left_click"):
		for child in get_children():
			if child is CharterNode and child.get_rect().has_point(mouse_pos):
				node_dragging = child
				node_drag_offset = mouse_pos - node_dragging.position
				break
	
	if Input.is_action_just_released("left_click"):
		node_dragging = null
	
	if node_dragging:
		node_dragging.position = mouse_pos - node_drag_offset
