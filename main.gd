extends Node2D

@onready var state_text: Label = $"DebugText/State";
@onready var mode_text: Label = $"DebugText/Mode"
@onready var zoom_text: Label = $DebugText/Zoom

func _process(_delta: float) -> void:
	state_text.text = "State: " + str(States.state);
	mode_text.text = "Mode: " + str(States.mode);
	zoom_text.text = "Zoom: " + str(get_viewport().get_camera_2d().zoom)
