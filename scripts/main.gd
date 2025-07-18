extends Node2D

@onready var ui = $Ui;

@onready var state_text = $"CanvasLayer/State";
@onready var ui_hover_text = $"CanvasLayer/UiHover";
@onready var mode_text = $"CanvasLayer/Mode"

func _process(_delta: float) -> void:
	ui_hover_text.text = "Is hovering" if ui.mouse_hovering else "Not hovering";
	state_text.text = "State: " + str(States.state);
	mode_text.text = "Mode: " + str(States.mode);
