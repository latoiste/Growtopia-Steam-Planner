extends CanvasLayer

@onready var block_container: GridContainer = $BlockSelector/PanelContainer/BlockContainer;
@onready var mode_container: HBoxContainer = $ModeContainer;

signal selected_block(block_name: String);
signal selected_mode(mode: String);

func _ready() -> void:
	for child in block_container.get_children():
		child.pressed.connect(select_block.bind(child.name.to_lower()));
			
	for child in mode_container.get_children():
		child.pressed.connect(select_mode.bind(child.name.to_lower()));
		
	#for child in camera_container.get_children():
		#if child is Button:
			#child.pressed.connect(change_camera_zoom.bind(child.name.to_lower()));

func select_block(block_name: String) -> void:
	selected_block.emit(block_name);

func select_mode(mode: String) -> void:
	selected_mode.emit(mode);
