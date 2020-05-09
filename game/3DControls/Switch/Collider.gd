extends KinematicBody


func _input_event( _camera,  event,  _click_position,  _click_normal,  _shape_idx ):
	if (event.is_action_pressed("ui_click")):
		get_parent().click()
