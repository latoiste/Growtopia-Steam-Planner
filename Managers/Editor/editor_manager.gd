extends Node
class_name EditorManager

enum State {IDLE, PLACE, DELETE, REPLACE};
enum Mode {SELECT, DRAW};

var state: State = State.IDLE;
var mode: Mode = Mode.DRAW:
	set(value):
		mode = value
		mode_changed.emit(value);

signal mode_changed(mode: Mode);

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("draw"):
		mode = Mode.DRAW;
	elif event.is_action_pressed("view"):
		mode = Mode.SELECT;

func set_state(selected_state: State) -> void:
	state = selected_state;
	
func set_mode(selected_mode: String) -> void:
	match selected_mode:
		"select":
			mode = Mode.SELECT;
		"draw":
			mode = Mode.DRAW;
