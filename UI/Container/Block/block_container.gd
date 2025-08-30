extends PanelContainer

@onready var block_selector: GridContainer = $MarginContainer/BlockSelector

func _ready() -> void:
	for child in block_selector.get_children():
		if child is Button:
			child.pressed.connect(Editor.set_selected_block.bind(child.name.to_lower()));
