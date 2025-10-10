extends CanvasLayer
class_name HUD

@onready var block_container: BlockContainer = $ButtonsContainer/PanelContainer/CenterContainer/BlockContainer
@onready var mode_container: ModeContainer = $ButtonsContainer/VBoxContainer/HBoxContainer/ModeContainer
@onready var undoredo_container: UndoredoContainer = $ButtonsContainer/VBoxContainer/HBoxContainer/UndoRedoContainer
@onready var save_container: HBoxContainer = $ButtonsContainer/VBoxContainer/HBoxContainer/SaveContainer
@onready var block_count_container: HBoxContainer = $ButtonsContainer/VBoxContainer/HBoxContainer/BlockCountContainer

@onready var block_count_popup: CustomPopup = $BlockCountPopup

signal block_selected(block_id: int);
signal mode_selected(mode: String);
signal undoredo_pressed(action: String);
signal saveload_pressed(action: String);

func _ready() -> void:
	connect_buttons(block_container, block_selected);
	connect_buttons(mode_container, mode_selected);
	connect_buttons(undoredo_container, undoredo_pressed);
	connect_buttons(save_container, saveload_pressed);
	
	block_count_container.block_count_pressed.connect(block_count_popup.show_popup);
	
func connect_buttons(container: Container, _signal: Signal) -> void:
	for child in container.get_children():
		if not child is Button:
			continue;
		child.pressed.connect(func():
			_signal.emit(child.get_meta("signal_params"));
		);
