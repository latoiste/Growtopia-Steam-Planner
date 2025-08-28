extends Node2D

@onready var world: Node2D = $"../WorldManager";
@onready var ui: CanvasLayer = $"../UI";
@onready var camera: Camera2D = get_viewport().get_camera_2d();

func _unhandled_input(event: InputEvent) -> void:
	match States.mode:
		States.Mode.DRAW:
			handle_draw_mode();
		States.Mode.SELECT:
			handle_select_mode(event);
				
func handle_draw_mode() -> void:
	if Input.is_action_pressed("left_click"):
		if world.can_place() and States.state != States.State.DELETE:
			States.set_state(States.State.PLACE);
			world.place_block();
		elif world.can_delete() and States.state != States.State.PLACE and States.state != States.State.REPLACE:
			States.set_state(States.State.DELETE);
			world.delete_block();
		elif world.can_replace() and States.state != States.State.DELETE:
			States.set_state(States.State.REPLACE);
			world.replace_block();
	elif Input.is_action_just_released("left_click"):
		States.set_state(States.State.IDLE);
		
func handle_select_mode(event: InputEvent):
	camera.pan_camera(event);

func _on_ui_selected_mode(mode: String) -> void:
	match mode:
		"select":
			States.set_mode(States.Mode.SELECT);
		"draw":
			States.set_mode(States.Mode.DRAW);
