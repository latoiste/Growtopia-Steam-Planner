extends Node2D
@onready var state_text: Label = $"DebugText/State";
@onready var mode_text: Label = $"DebugText/Mode"
@onready var zoom_text: Label = $DebugText/Zoom

@onready var camera: Camera2D = get_viewport().get_camera_2d();
@onready var hud: HUD = $HUD;
@onready var world: WorldManager = $WorldManager;
@onready var undoredo: UndoRedoManager = $UndoRedoManager;

@onready var managers := {
	"world": world,
	"undoredo": undoredo,
}

func _ready() -> void:
	world.block_placed.connect(undoredo.register_action.bind("place"));
	world.block_deleted.connect(undoredo.register_action.bind("delete"));
	
	hud.block_selected.connect(Editor.set_selected_block);
	hud.mode_selected.connect(Editor.set_mode);
	
	hud.undoredo_pressed.connect(undoredo.handle_undoredo_action);
	
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
		elif world.can_replace() and Editor.state != Editor.State.DELETE:
			Editor.set_state(Editor.State.REPLACE);
			world.replace_block();
	elif Input.is_action_pressed("right_click"):
		if world.can_delete() and Editor.state != Editor.State.PLACE and Editor.state != Editor.State.REPLACE:
			Editor.set_state(Editor.State.DELETE);
			world.delete_block();
	elif Input.is_action_just_released("left_click") or Input.is_action_just_released("right_click"):
		Editor.set_state(Editor.State.IDLE);
		undoredo.update_undo_stack();
		
func handle_select_mode(event: InputEvent) -> void:
	if Input.is_action_pressed("left_click") and event is InputEventMouseMotion:
		camera.pan_camera(event);

func get_manager(manager: String) -> Node:
	return managers.get(manager);

func _process(_delta: float) -> void:
	state_text.text = "State: " + str(Editor.state);
	mode_text.text = "Mode: " + str(Editor.mode);
	zoom_text.text = "Zoom: " + str(get_viewport().get_camera_2d().zoom)
