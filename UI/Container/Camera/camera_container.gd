extends HBoxContainer

@onready var camera: Camera2D = get_viewport().get_camera_2d();

signal on_zoom_out;
signal on_zoom_in;

func _ready() -> void:
	for child in get_children():
		if child is Button:
			child.pressed.connect(change_camera_zoom.bind(child.name.to_lower()));
	
	if camera:
		on_zoom_out.connect(camera.zoom_out);
		on_zoom_in.connect(camera.zoom_in);

func change_camera_zoom(mode: String) -> void:
	match mode:
		"zoomout":
			on_zoom_out.emit();
		"zoomin":
			on_zoom_in.emit();
