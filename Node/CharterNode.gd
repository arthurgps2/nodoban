class_name CharterNode
extends PanelContainer

func get_center() -> Vector2:
	return position + size/2

func delete() -> void:
	for child in get_node("..").get_children():
		if child is CharterLink and (child.start_node == self or child.end_node == self):
			child.queue_free()
	queue_free()
