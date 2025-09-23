extends CanvasLayer
class_name HUD

@onready var block_container: GridContainer = $PanelContainer/MarginContainer/BlockContainer
@onready var mode_container: HBoxContainer = $VBoxContainer/HBoxContainer/ModeContainer
@onready var undoredo_container: HBoxContainer = $VBoxContainer/HBoxContainer/UndoRedoContainer
@onready var save_container: HBoxContainer = $VBoxContainer/HBoxContainer/SaveContainer

signal block_selected(block_name: String);
signal mode_selected(mode: String);
signal undoredo_pressed(action: String);
signal saveload_pressed(action: String);

func _ready() -> void:
	connect_buttons(block_container, block_selected);
	connect_buttons(mode_container, mode_selected);
	connect_buttons(undoredo_container, undoredo_pressed);
	connect_buttons(save_container, saveload_pressed);

func connect_buttons(container: Container, _signal: Signal) -> void:
	for child in container.get_children():
		if not child is Button:
			continue;
		child.pressed.connect(func():
			_signal.emit(child.name.to_lower());
		);
