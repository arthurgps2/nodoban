extends Control

const zoom_factor := .05

var node_dragging : CharterNode = null
var node_drag_offset : Vector2
var view_dragging := false
var view_drag_offset : Vector2

func _process(delta: float) -> void:
	# Node management
	var mouse_pos := get_global_mouse_position()
	
	if Input.is_action_just_pressed("left_click"):
		var node_under := get_node_under_mouse()
		if node_under:
			node_dragging = node_under
			node_drag_offset = mouse_pos - node_dragging.global_position
		
		if not node_dragging:
			view_dragging = true
			view_drag_offset = mouse_pos - position
	
	if Input.is_action_just_released("left_click"):
		node_dragging = null
		view_dragging = false
	
	# Dragging nodes
	if node_dragging:
		node_dragging.global_position = mouse_pos - node_drag_offset
	# Dragging view
	elif view_dragging:
		position = mouse_pos - view_drag_offset
	
	# Zoom in/out
	if Input.is_action_just_pressed("scroll_up"):
		var add := zoom_factor * scale
		scale += add
	
	if Input.is_action_just_pressed("scroll_down"):
		var sub = zoom_factor * scale
		scale -= sub

func get_node_under_mouse() -> CharterNode:
	for child in get_children():
		if child is CharterNode and child.get_global_rect().has_point(get_global_mouse_position()):
			return child
	
	return null
