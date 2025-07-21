extends Node2D

@onready var state_text = $"CanvasLayer/State";
@onready var mode_text = $"CanvasLayer/Mode"

func _process(_delta: float) -> void:
	state_text.text = "State: " + str(States.state);
	mode_text.text = "Mode: " + str(States.mode);
