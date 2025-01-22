class_name CharterNode
extends PanelContainer

const color_valid_type := Color(1, 1, 1)
const color_invalid_type := Color(1, 0, 0)
const charter_property_scene : PackedScene = preload("res://Property/CharterProperty.tscn")

var type := "node"

func _process(_delta: float) -> void:
	%NodeTypeName.text = "[center]" + type
	size = custom_minimum_size
	
	# Warn user for invalid node types
	modulate = (color_valid_type if ChartInfo.get_node_type_by_name(type) 
		else color_invalid_type)

func get_node_info() -> Dictionary:
	var info = {
		type = self.type,
		__posx = position.x,
		__posy = position.y,
	}
	var overwrites = get_node_overwrites()
	for overwrite_key in overwrites:
		info[overwrite_key] = overwrites[overwrite_key]
	
	return info

func get_node_overwrites() -> Dictionary:
	var overwrites = {}
	for child in $NameAndOverwriteContainer.get_children():
		if child is not CharterProperty: continue
		var property : CharterProperty = child
		overwrites[property.get_property_name()] = property.get_property_value()
	
	return overwrites

func get_center() -> Vector2:
	return position + size/2

func add_new_override() -> void:
	var charter_property = charter_property_scene.instantiate()
	$NameAndOverwriteContainer.add_child(charter_property)

func delete() -> void:
	for child in get_node("..").get_children():
		if child is CharterLink and (child.start_node == self or child.end_node == self):
			child.queue_free()
	queue_free()
