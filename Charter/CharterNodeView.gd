extends Control

enum EMPTY_MENU_ITEM_ID {
	NEW_NODE = 0
}

enum NODE_MENU_ITEM_ID {
	NEW_LINK = 0,
	DELETE_NODE = 1,
}

enum LINK_MENU_ITEM_ID {
	NEW_PROPERTY = 0,
	DELETE_LINK = 1,
}

const zoom_factor := .05
const charter_node_scene : PackedScene = preload("res://Node/CharterNode.tscn")
const charter_link_scene : PackedScene = preload("res://Link/CharterLink.tscn")

var node_dragging : CharterNode
var node_drag_offset : Vector2
var view_dragging := false
var view_drag_offset : Vector2
var node_in_context : CharterNode
var link_in_context : CharterLink
var link_being_made : CharterLink

@onready var empty_cmenu : PopupMenu = $EmptyRMBClickContextMenu
@onready var node_cmenu : PopupMenu = $NodeRMBClickContextMenu
@onready var link_cmenu : PopupMenu = $LinkRMBClickContextMenu
@onready var node_types_window : Window = get_node("../UI/NodeTypes")

func _process(delta: float) -> void:
	# Node management
	var mouse_pos := get_global_mouse_position()
	
	if Input.is_action_just_pressed("left_click") and not node_types_window.has_focus():
		var node_under := get_node_under_mouse()
		
		if link_being_made:
			if node_under:
				link_being_made.end_node = node_under
				link_being_made.end_point = node_under.position
			else:
				link_being_made.queue_free()
				
			link_being_made = null
		else:
			if node_under:
				node_dragging = node_under
				node_drag_offset = mouse_pos - node_dragging.global_position
			else:
				view_dragging = true
				view_drag_offset = mouse_pos - position
	
	if Input.is_action_just_released("left_click"):
		node_dragging = null
		view_dragging = false
	
	if Input.is_action_just_pressed("right_click") and not node_types_window.has_focus():
		var node_under = get_node_under_mouse()
		var link_under = get_link_under_mouse()
		
		if node_under:
			empty_cmenu.hide()
			link_cmenu.hide()
			
			node_cmenu.position = get_global_mouse_position()
			node_cmenu.show()
			node_in_context = node_under
		elif link_under:
			empty_cmenu.hide()
			node_cmenu.hide()
			
			link_cmenu.position = get_global_mouse_position()
			link_cmenu.show()
			link_in_context = link_under
		else: # Clicked on the void
			node_cmenu.hide()
			link_cmenu.hide()
			
			empty_cmenu.position = get_global_mouse_position()
			empty_cmenu.show()
	
	# Dragging nodes
	if node_dragging:
		node_dragging.global_position = mouse_pos - node_drag_offset
	# Dragging view
	elif view_dragging:
		position = mouse_pos - view_drag_offset
	
	# Zoom in/out
	if Input.is_action_just_pressed("scroll_up") and not node_types_window.has_focus():
		var add := zoom_factor * scale
		scale += add
	
	if Input.is_action_just_pressed("scroll_down") and not node_types_window.has_focus():
		var sub = zoom_factor * scale
		scale -= sub
	
	# Update link being made
	if link_being_made:
		link_being_made.start_point = link_being_made.start_node.get_center()
		link_being_made.end_point = get_local_mouse_position()

func _on_empty_menu_index_pressed(index: int) -> void:
	match index:
		EMPTY_MENU_ITEM_ID.NEW_NODE: # Create new node
			var charter_node := charter_node_scene.instantiate()
			charter_node.global_position = ((get_global_mouse_position() - position) / scale
				- charter_node.size/2)
			add_child(charter_node)

func _on_node_menu_index_pressed(index: int) -> void:
	match index:
		NODE_MENU_ITEM_ID.NEW_LINK: # Create new link
			link_being_made = charter_link_scene.instantiate()
			link_being_made.start_node = node_in_context
			add_child(link_being_made)
		NODE_MENU_ITEM_ID.DELETE_NODE: # Delete node
			node_in_context.delete()
	
	node_in_context = null

func _on_link_menu_index_pressed(index: int) -> void:
	match index:
		LINK_MENU_ITEM_ID.NEW_PROPERTY:
			pass
		LINK_MENU_ITEM_ID.DELETE_LINK:
			link_in_context.queue_free()
	
	link_in_context = null


func get_node_under_mouse() -> CharterNode:
	for child in get_children():
		if child is CharterNode and child.get_global_rect().has_point(get_global_mouse_position()):
			return child
	
	return null

func get_link_under_mouse() -> CharterLink:
	for child in get_children():
		if (child is CharterLink 
		and Geometry2D.get_closest_point_to_segment(
		get_local_mouse_position(), child.start_point, child.end_point)
		.distance_squared_to(get_local_mouse_position()) < 400):
			return child
	
	return null
