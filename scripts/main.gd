extends Node2D
@onready var world = $WorldManager
@onready var state_text = $State
@onready var ui_hover_text = $UiHover
@onready var ui = $Ui

enum Mode {IDLE, PLACE, DELETE, REPLACE};
var current_state: Mode = Mode.IDLE;
var selected_block: String;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_pressed("left_click") and not ui.mouse_hovering:
		if world.can_place() and current_state != 2:
			current_state = Mode.PLACE;
			world.place_block();
		elif world.can_delete() and current_state != 1 and current_state != 3:
			current_state = Mode.DELETE;
			world.delete_block();
		elif world.can_replace() and current_state != 2:
			current_state = Mode.REPLACE;
			world.replace_block();
	elif Input.is_action_just_released("left_click"):
		current_state = Mode.IDLE;
	
	ui_hover_text.text = "Is hovering" if ui.mouse_hovering else "Not hovering"
	state_text.text = "State: " + str(current_state)

func set_state():
	if world.can_place():
		current_state = Mode.PLACE;
	elif world.can_delete():
		current_state = Mode.DELETE;
	elif world.can_replace():
		current_state = Mode.REPLACE;

func _on_ui_selected_block(block_name: String) -> void:
	selected_block = block_name;
