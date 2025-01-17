class_name CharterNode
extends PanelContainer

func get_center() -> Vector2:
	return position + size/2

func delete() -> void:
	queue_free()
