extends CanvasLayer

@onready var container = $VBoxContainer;
signal selected_block(block_name: String);

var mouse_hovering: bool = false;

func _ready() -> void:
	for child in container.get_children():
		if child is Button:
			child.mouse_entered.connect(mouse_entered);
			child.mouse_exited.connect(mouse_exited);
			
			child.pressed.connect(select_block.bind(child.name.to_lower()));

func select_block(block_name: String) -> void:
	selected_block.emit(block_name);

func mouse_exited() -> void:
	mouse_hovering = false;

func mouse_entered() -> void:
	mouse_hovering = true;
