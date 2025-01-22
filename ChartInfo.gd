extends Node

@onready var ui : CharterUI = get_node("/root/Charter/UI")
@onready var node_view : CharterNodeView = get_node("/root/Charter/NodeView")

var node_types : Array = []
var nodes : Array = []
var links : Array = []

# Save JSON file
func save_to_file(path : String) -> void:
	var chart = {
		node_types = {},
		nodes = [],
		links = [],
	}
	
	# Store node types
	for node_type : CharterNodeTypeMenu in node_types:
		chart.node_types[node_type.get_node_type_name()] = node_type.get_node_type_properties()
	
	# Store nodes
	for node : CharterNode in nodes:
		chart.nodes.append(node.get_node_info())
	
	# Store links
	for link : CharterLink in links:
		chart.links.append(link.get_link_info())
	
	# Create JSON
	var chart_json = JSON.stringify(chart)
	
	# Finally, save JSON to file
	var file = FileAccess.open(path, FileAccess.WRITE)
	file.store_line(chart_json)
	file.close()
	
# Load JSON file
func load_from_file(path : String) -> void:
	# Load JSON file
	var file = FileAccess.open(path, FileAccess.READ)
	var chart_json = file.get_line()
	file.close()
	
	# Parse JSON and clear vars
	var chart = JSON.parse_string(chart_json)
	
	# Clear everything
	ui.clear_node_types()
	node_view.clear_nodes_and_links()
	
	node_types = []
	nodes = []
	links = []
	
	# Load node types
	for node_type in chart.node_types:
		var charter_node_type = ui.add_new_node_type()
		charter_node_type.set_node_type_name(node_type)
		charter_node_type.set_node_type_properties(chart.node_types[node_type])
	
	# Load nodes
	for node in chart.nodes:
		var charter_node = node_view.add_new_node()
		charter_node.set_node_info(node)
	
	# Load links
	for link in chart.links:
		var charter_link = node_view.add_new_link()
		charter_link.set_link_info(link)

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
