extends Node2D
@onready var state_text: Label = $"DebugText/State";
@onready var mode_text: Label = $"DebugText/Mode"
@onready var zoom_text: Label = $DebugText/Zoom

@onready var camera: Camera2D = get_viewport().get_camera_2d();
@onready var hud: HUD = $HUD;
@onready var world: WorldManager = $WorldManager;
@onready var undoredo: UndoRedoManager = $UndoRedoManager;
@onready var editor: EditorManager = $EditorManager
@onready var save: SaveManager = $SaveManager

@onready var managers := {
	"world": world,
	"undoredo": undoredo,
	"editor": editor,
	"save": save,
}

func _ready() -> void:
	world.block_placed.connect(undoredo.register_action.bind("place"));
	world.block_deleted.connect(undoredo.register_action.bind("delete"));
	hud.undoredo_pressed.connect(undoredo.handle_undoredo_action);
	
	hud.block_selected.connect(world.set_selected_block);
	save.world_loaded.connect(world.clear_world);
	
	hud.mode_selected.connect(editor.set_mode);
	hud.block_selected.connect(func(_selected_block: String):
		editor.set_mode("draw");
	);
	
	hud.saveload_pressed.connect(save.handle_saveload_action);
	
	undoredo.stack_changed.connect(hud.undoredo_container.disable_button);
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("undo"):
		undoredo.undo();
	elif event.is_action_pressed("redo"):
		undoredo.redo();
	elif event.is_action_pressed("draw"):
		editor.mode = editor.Mode.DRAW;
	elif event.is_action_pressed("view"):
		editor.mode = editor.Mode.SELECT;
	
func _unhandled_input(event: InputEvent) -> void:
	match editor.mode:
		editor.Mode.DRAW:
			handle_draw_mode();
		editor.Mode.SELECT:
			handle_select_mode(event);
	
func handle_draw_mode() -> void:
	if Input.is_action_pressed("left_click"):
		if world.can_place() and editor.state != editor.State.DELETE:
			editor.set_state(editor.State.PLACE);
			world.place_block();
		elif world.can_replace() and editor.state != editor.State.DELETE:
			editor.set_state(editor.State.REPLACE);
			world.replace_block();
	elif Input.is_action_pressed("right_click"):
		if world.can_delete() and editor.state != editor.State.PLACE and editor.state != editor.State.REPLACE:
			editor.set_state(editor.State.DELETE);
			world.delete_block();
	elif Input.is_action_just_released("left_click") or Input.is_action_just_released("right_click"):
		editor.set_state(editor.State.IDLE);
		undoredo.update_undo_stack();
		
func handle_select_mode(event: InputEvent) -> void:
	if Input.is_action_pressed("left_click") and event is InputEventMouseMotion:
		camera.pan_camera(event);

func get_manager(manager: String) -> Node:
	return managers.get(manager);

func _process(_delta: float) -> void:
	state_text.text = "State: " + str(editor.state);
	mode_text.text = "Mode: " + str(editor.mode);
	zoom_text.text = "Zoom: " + str(get_viewport().get_camera_2d().zoom)
