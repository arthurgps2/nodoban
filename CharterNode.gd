extends PanelContainer

var being_dragged := false
var drag_offset := Vector2()

func _process(_delta: float) -> void:
	var mouse_pos := get_global_mouse_position()
	
	if Input.is_action_just_pressed("left_click") and get_rect().has_point(mouse_pos):
		being_dragged = true
		drag_offset = position - mouse_pos
	
	if Input.is_action_just_released("left_click"):
		being_dragged = false
	
	if being_dragged:
		position = mouse_pos + drag_offset
