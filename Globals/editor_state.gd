extends Node

enum Mode {SELECT, DRAW};
enum State {IDLE, PLACE, DELETE, REPLACE};

var mode: Mode = Mode.DRAW;
var state: State = State.IDLE;
var selected_block_id: int;
var BlockScene: PackedScene:
	set(value):
		Editor.mode = Editor.Mode.DRAW;
		BlockScene = value;

func set_state(selected_state: State) -> void:
	state = selected_state;
	
func set_mode(selected_mode: String) -> void:
	match selected_mode:
		"select":
			mode = Mode.SELECT;
		"draw":
			mode = Mode.DRAW;
	#mode = selected_mode;

func set_selected_block(selected_block: String) -> void:
	selected_block_id = Constants.BLOCK_ID.get(selected_block);
	var scene_path = ScenePaths.BLOCKS.get(selected_block.to_lower());
	if scene_path:
		BlockScene = load(scene_path);

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("draw"):
		Editor.mode = Editor.Mode.DRAW;
	elif event.is_action_pressed("view"):
		Editor.mode = Editor.Mode.SELECT;
