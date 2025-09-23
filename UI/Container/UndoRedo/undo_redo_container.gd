extends HBoxContainer

@onready var undo_button: ButtonTextHover = $Undo
@onready var redo_button: ButtonTextHover = $Redo

func _ready() -> void:
	undo_button.disabled = true;
	redo_button.disabled = true;

func disable_button(undo_empty: bool, redo_empty: bool) -> void:
	if undo_empty:
		undo_button.disabled = true;
		redo_button.disabled = false;
	elif redo_empty:
		redo_button.disabled = true;
		undo_button.disabled = false;
