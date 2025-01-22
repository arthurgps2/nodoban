class_name CharterLink
extends Control

const line_color := Color(1, 1, 1)
const line_width := 2.5
const arrow_size := 10
const charter_property_scene : PackedScene = preload("res://Property/CharterProperty.tscn")

var start_point := Vector2()
var center_point := Vector2()
var end_point := Vector2()

var start_node : CharterNode
var end_node : CharterNode

func add_new_property() -> CharterProperty:
	var charter_property = charter_property_scene.instantiate()
	$OverwriteContainer.add_child(charter_property)
	
	return charter_property

func get_link_info() -> Dictionary:
	var info := {from = null, to = null}
	var nodes := ChartInfo.get_nodes()
	for i in nodes.size():
		var node = nodes[i]
		if node == start_node: info.from = i
		elif node == end_node: info.to = i
	
	for child in $OverwriteContainer.get_children():
		if child is not CharterProperty: continue
		var property : CharterProperty = child
		info[property.get_property_name()] = property.get_property_value()
	
	return info

func set_link_info(info : Dictionary) -> void:
	# Start and end nodes
	start_node = ChartInfo.nodes[info.from]
	end_node = ChartInfo.nodes[info.to]
	
	# Other properties
	for key in info:
		if key == "from" or key == "to": continue
		var property := add_new_property()
		property.set_property_name(key)
		property.set_property_value(info[key])

func _draw():
	# Main line
	draw_line(start_point, end_point, line_color, line_width)
	
	# Arrow heads
	var heads : int = max(floori(start_point.distance_to(end_point) / 75), 1)
	for i in range(1, heads + 1): draw_triangle_on_line(float(i) / heads)

func _process(_delta):
	if start_node and end_node:
		start_point = start_node.get_center()
		end_point = end_node.get_center()
		
		var start_intersect = line_intersects_rect(start_point, end_point, start_node.get_rect())
		if start_intersect: start_point = start_intersect
		
		var end_intersect = line_intersects_rect(start_point, end_point, end_node.get_rect())
		if end_intersect: end_point = end_intersect
	
	center_point = lerp(start_point, end_point, .5)
	
	$OverwriteContainer.size = $OverwriteContainer.custom_minimum_size
	$OverwriteContainer.position = center_point - $OverwriteContainer.size / 2
	
	queue_redraw()

func draw_triangle_on_line(position : float) -> void:
	var direction = (end_point - start_point).normalized()
	var perp = Vector2(-direction.y, direction.x)
	
	var tip = lerp(start_point, end_point, position)
	var base1 = tip - (direction - perp) * arrow_size
	var base2 = tip - (direction + perp) * arrow_size
	
	draw_polygon([tip, base1, base2], [line_color])

func line_intersects_rect(from : Vector2, to : Vector2, rect : Rect2) -> Variant:
	# Top side
	var rect_from := rect.position
	var rect_to := rect_from + Vector2(rect.size.x, 0)
	var intersect = Geometry2D.segment_intersects_segment(from, to, rect_from, rect_to)
	if intersect: return intersect
	
	# Right side
	rect_from = rect.position + Vector2(rect.size.x, 0)
	rect_to = rect_from + Vector2(0, rect.size.y)
	intersect = Geometry2D.segment_intersects_segment(from, to, rect_from, rect_to)
	if intersect: return intersect
	
	# Bottom side
	rect_from = rect.position + Vector2(0, rect.size.y)
	rect_to = rect_from + Vector2(rect.size.x, 0)
	intersect = Geometry2D.segment_intersects_segment(from, to, rect_from, rect_to)
	if intersect: return intersect
	
	# Left side
	rect_from = rect.position
	rect_to = rect_from + Vector2(0, rect.size.y)
	intersect = Geometry2D.segment_intersects_segment(from, to, rect_from, rect_to)
	if intersect: return intersect
	
	# No intersection
	return null
