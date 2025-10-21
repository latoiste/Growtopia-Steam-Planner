extends HBoxContainer
class_name PopupContainer

@onready var block_count_button: ButtonTextHover = $BlockCount
@onready var bug_report_button: ButtonTextHover = $BugReport

signal block_count_pressed;
signal bug_report_pressed;

func _ready() -> void:
	block_count_button.pressed.connect(func():
		block_count_pressed.emit();
	);
	
	bug_report_button.pressed.connect(func():
		bug_report_pressed.emit();
	);
