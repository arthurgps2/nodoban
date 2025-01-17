extends Control

const zoom_factor := .05
const charter_node_scene : PackedScene = preload("res://CharterNode.tscn")

var node_dragging : CharterNode = null
var node_drag_offset : Vector2
var view_dragging := false
var view_drag_offset : Vector2

@onready var empty_menu = $EmptyRMBClickContextMenu
@onready var node_menu = $NodeRMBClickContextMenu

func _process(delta: float) -> void:
	# Node management
	var mouse_pos := get_global_mouse_position()
	
	if Input.is_action_just_pressed("left_click"):
		var node_under := get_node_under_mouse()
		if node_under:
			node_dragging = node_under
			node_drag_offset = mouse_pos - node_dragging.global_position
		else:
			view_dragging = true
			view_drag_offset = mouse_pos - position
	
	if Input.is_action_just_released("left_click"):
		node_dragging = null
		view_dragging = false
	
	if Input.is_action_just_pressed("right_click"):
		var node_under = get_node_under_mouse()
		if node_under:
			node_menu.position = get_global_mouse_position()
			node_menu.visible = true
		else: # Clicked on the void
			empty_menu.position = get_global_mouse_position()
			empty_menu.visible = true
	
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

func _on_empty_menu_index_pressed(index: int) -> void:
	match index:
		0:
			var charter_node := charter_node_scene.instantiate()
			charter_node.global_position = get_global_mouse_position()
			add_child(charter_node)

func get_node_under_mouse() -> CharterNode:
	for child in get_children():
		if child is CharterNode and child.get_global_rect().has_point(get_global_mouse_position()):
			return child
	
	return null
