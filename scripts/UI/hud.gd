extends CanvasLayer

@onready var block_container = $BlockContainer;
@onready var mode_container = $ModeContainer;
@onready var camera_container = $CameraContainer;

signal selected_block(block_name: String);
signal selected_mode(mode: String);

var mouse_hovering: bool = false;

func _ready() -> void:
	for child in block_container.get_children():
		if child is Button:
			child.mouse_entered.connect(mouse_entered);
			child.mouse_exited.connect(mouse_exited);
			
			child.pressed.connect(select_block.bind(child.name.to_lower()));
			
	for child in mode_container.get_children():
		if child is Button:
			child.mouse_entered.connect(mouse_entered);
			child.mouse_exited.connect(mouse_exited);
			
			child.pressed.connect(select_mode.bind(child.name.to_lower()));

func select_block(block_name: String) -> void:
	selected_block.emit(block_name);

func select_mode(mode: String) -> void:
	selected_mode.emit(mode);

func mouse_exited() -> void:
	mouse_hovering = false;

func mouse_entered() -> void:
	mouse_hovering = true;
