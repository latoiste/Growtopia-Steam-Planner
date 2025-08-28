extends Camera2D

func pan_camera(event: InputEvent) -> void:
	if Input.is_action_pressed("left_click") and event is InputEventMouseMotion:
		position -= event.relative / zoom;

func zoom_in() -> void:
	if zoom == Constants.MAX_ZOOM_IN:
		return;
	zoom += Vector2(0.5, 0.5);
	fix_camera_position();
	
func zoom_out() -> void:
	if zoom == Constants.MAX_ZOOM_OUT:
		return;
	zoom -= Vector2(0.5, 0.5);
	fix_camera_position();
	
func fix_camera_position() -> void:
	var camera_size := Vector2(get_viewport().size)/zoom;
	var left_difference := camera_size.x/2 - position.x + limit_left;
	var right_difference := camera_size.x/2 + position.x - limit_right; 
	var top_difference := camera_size.y/2 - position.y + limit_top;
	var bottom_difference := camera_size.y/2 + position.y - limit_bottom;
	
	if left_difference > 0:
		position.x += left_difference
	elif right_difference > 0:
		position.x -= right_difference;
	
	if top_difference > 0:
		position.y += top_difference;
	elif bottom_difference > 0:
		position.y -= bottom_difference;
