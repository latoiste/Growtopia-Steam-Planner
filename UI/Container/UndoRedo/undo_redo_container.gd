extends HBoxContainer

@onready var undo_button: ButtonTextHover = $Undo;
@onready var redo_button: ButtonTextHover = $Redo;

#func _ready() -> void:
	#undo_button.pressed.connect(UndoredoManager.undo);
	#redo_button.pressed.connect(UndoredoManager.redo);
