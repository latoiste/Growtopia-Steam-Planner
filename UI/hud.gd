extends CanvasLayer
class_name HUD

@onready var block_container: BlockContainer = $ButtonsContainer/PanelContainer/CenterContainer/BlockContainer
@onready var mode_container: ModeContainer = $ButtonsContainer/VBoxContainer/HBoxContainer/ModeContainer
@onready var undoredo_container: UndoredoContainer = $ButtonsContainer/VBoxContainer/HBoxContainer/UndoRedoContainer
@onready var save_container: HBoxContainer = $ButtonsContainer/VBoxContainer/HBoxContainer/SaveContainer
@onready var popup_container: PopupContainer = $ButtonsContainer/VBoxContainer/HBoxContainer/PopupContainer

@onready var popup_overlay: PopupOverlay = $PopupOverlay
@onready var bug_report_popup: BugReportPopup = $PopupOverlay/BugReportPopup
@onready var block_count_popup: BlockCountPopup = $PopupOverlay/BlockCountPopup

signal block_selected(block_id: int);
signal mode_selected(mode: String);
signal undoredo_pressed(action: String);
signal saveload_pressed(action: String);

func _ready() -> void:
	connect_buttons(block_container, block_selected);
	connect_buttons(mode_container, mode_selected);
	connect_buttons(undoredo_container, undoredo_pressed);
	connect_buttons(save_container, saveload_pressed);
	
	connect_popup(bug_report_popup, popup_container.bug_report_pressed)
	connect_popup(block_count_popup, popup_container.block_count_pressed)
	
func connect_buttons(container: Container, _signal: Signal) -> void:
	for child in container.get_children():
		if not child is Button:
			continue;
		child.pressed.connect(func():
			_signal.emit(child.get_meta("signal_params"));
		);

func connect_popup(popup: Container, _signal: Signal) -> void:
	_signal.connect(func(): 
		popup_overlay.show_popup(popup);
	);
