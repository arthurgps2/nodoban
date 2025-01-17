class_name CharterLink
extends Control

const line_color := Color(1, 1, 1)
const line_width := 2.5
const arrow_size = 10

var start_point := Vector2()
var end_point := Vector2()

var start_node : CharterNode
var end_node : CharterNode

func _draw():
	# Main line
	draw_line(start_point, end_point, line_color, line_width)
	
	# Arrow head
	var direction = (end_point - start_point).normalized()
	var perp = Vector2(-direction.y, direction.x)
	
	var base1 = end_point - (direction - perp) * arrow_size
	var base2 = end_point - (direction + perp) * arrow_size
	
	draw_polygon([end_point, base1, base2], [line_color])

func _process(_delta):
	if start_node and end_node:
		start_point = start_node.get_center()
		end_point = end_node.get_center()
	
	queue_redraw()
