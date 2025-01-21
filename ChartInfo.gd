extends Node

var node_types : Array = []
var nodes : Array = []
var links : Array = []

# Node types
func add_node_type(node_type : CharterNodeTypeMenu) -> void:
	node_types.append(node_type)

func get_node_types() -> Array:
	return node_types

func get_node_type_by_name(name : String) -> CharterNodeTypeMenu:
	for node_type in node_types:
		if node_type.get_node_type_name() == name: return node_type
	
	return null

func remove_node_type(node_type : CharterNodeTypeMenu) -> void:
	node_types.erase(node_type)

# Nodes
func add_node(node : CharterNode) -> void:
	nodes.append(node)

func get_nodes() -> Array:
	return nodes

func remove_node(node : CharterNode) -> void:
	nodes.erase(node)

# Links
func add_link(link : CharterLink) -> void:
	links.append(link)

func get_links() -> Array:
	return links

func remove_link(link : CharterLink) -> void:
	links.erase(link)
