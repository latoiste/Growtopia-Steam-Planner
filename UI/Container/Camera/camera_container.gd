extends HBoxContainer

@onready var camera: Camera2D = get_viewport().get_camera_2d();

signal zoom_out;
signal zoom_in;
signal reset

func _ready() -> void:
	for child in get_children():
		if child is Button:
			child.pressed.connect(change_camera_zoom.bind(child.name.to_lower()));
	if camera:
		zoom_out.connect(camera.zoom_out);
		zoom_in.connect(camera.zoom_in);
		reset.connect(camera.reset);

func change_camera_zoom(mode: String) -> void:
	match mode:
		"zoomout":
			zoom_out.emit();
		"zoomin":
			zoom_in.emit();
		"reset":
			reset.emit();
