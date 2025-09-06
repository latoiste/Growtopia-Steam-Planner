extends Node2D

@export var world: Node2D;
@onready var camera: Camera2D = get_viewport().get_camera_2d();

func _unhandled_input(event: InputEvent) -> void:
	match Editor.mode:
		Editor.Mode.DRAW:
			handle_draw_mode();
		Editor.Mode.SELECT:
			handle_select_mode(event);
				
func handle_draw_mode() -> void:
	if Input.is_action_pressed("left_click"):
		if world.can_place() and Editor.state != Editor.State.DELETE:
			Editor.set_state(Editor.State.PLACE);
			world.place_block();
		elif world.can_delete() and Editor.state != Editor.State.PLACE and Editor.state != Editor.State.REPLACE:
			Editor.set_state(Editor.State.DELETE);
			world.delete_block();
		elif world.can_replace() and Editor.state != Editor.State.DELETE:
			Editor.set_state(Editor.State.REPLACE);
			world.replace_block();
	elif Input.is_action_just_released("left_click"):
		Editor.set_state(Editor.State.IDLE);
		
func handle_select_mode(event: InputEvent):
	if Input.is_action_pressed("left_click") and event is InputEventMouseMotion:
		camera.pan_camera(event);
