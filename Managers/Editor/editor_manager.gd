extends Node
class_name EditorManager

enum Mode {SELECT, DRAW};
enum State {IDLE, PLACE, DELETE, REPLACE};

var mode: Mode = Mode.DRAW;
var state: State = State.IDLE;

func set_state(selected_state: State) -> void:
	state = selected_state;
	
func set_mode(selected_mode: String) -> void:
	match selected_mode:
		"select":
			mode = Mode.SELECT;
		"draw":
			mode = Mode.DRAW;
