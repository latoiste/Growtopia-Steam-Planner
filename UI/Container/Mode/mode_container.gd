extends HBoxContainer
class_name ModeContainer

const button_group_path: ButtonGroup = preload("res://UI/Buttons/Group/mode_button_group.tres");

@onready var select_button: ButtonTextHover = $Select
@onready var draw_button: ButtonTextHover = $Draw

func _ready() -> void:
	for child in get_children():
		if child is Button:
			child.button_group = button_group_path;

func on_mode_selected(mode: EditorManager.Mode) -> void:
	if mode == EditorManager.Mode.SELECT:
		select_button.button_pressed = true;
	elif mode == EditorManager.Mode.DRAW:
		draw_button.button_pressed = true;
