extends HBoxContainer

@onready var block_count_button: ButtonTextHover = $BlockCountButton

signal block_count_pressed;

func _ready() -> void:
	block_count_button.pressed.connect(func():
		block_count_pressed.emit()
	);
