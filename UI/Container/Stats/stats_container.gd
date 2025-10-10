extends HBoxContainer

@onready var x_coords: Label = $XCoords
@onready var y_coords: Label = $YCoords
@onready var current_block: Label = $Block

func _process(delta: float) -> void:
	var mouse_pos := get_viewport().get_camera_2d().get_global_mouse_position();
	var grid_pos = Grid.get_grid_pos(mouse_pos);
	var block := Grid.get_block_at(grid_pos);
	
	x_coords.text = "X: %d" % (grid_pos.x + 1);
	y_coords.text = "Y: %d" % (grid_pos.y + 1);
	current_block.text = "Block: %s" % (block.get_block_name() if block else "-")
