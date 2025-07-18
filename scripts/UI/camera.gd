extends Camera2D

func out_of_bounds(move_pos: Vector2) -> bool:
	# left limit
	if position.x < limit_left:
		return true;
	# right limit
	if (position.x + move_pos.x) > get_viewport().size.x - (limit_right / zoom.x):
		return true;
	#top limit
	if (position.y - move_pos.y) < limit_top:
		return true;
	#bottom limit
	if (position.y + move_pos.y) > get_viewport().size.y - (limit_bottom / zoom.y):
		return true;
	
	return false;

func pan_camera(event: InputEvent) -> void:
	if Input.is_action_pressed("left_click") and event is InputEventMouseMotion:
		#print(event.relative)
		#if not out_of_bounds(event.relative):
		position -= event.relative / zoom;
			#print(position)
