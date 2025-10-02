extends HBoxContainer
class_name UndoredoContainer

@onready var undo_button: ButtonTextHover = $Undo
@onready var redo_button: ButtonTextHover = $Redo

func _ready() -> void:
	undo_button.disabled = true;
	redo_button.disabled = true;

func on_stack_changed(undo_empty: bool, redo_empty: bool) -> void:
	undo_button.disabled = undo_empty;
	redo_button.disabled = redo_empty;
		
