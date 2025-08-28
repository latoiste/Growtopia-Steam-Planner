extends Node

enum Mode {SELECT, DRAW};
enum State {IDLE, PLACE, DELETE, REPLACE};

var mode: Mode = Mode.DRAW;
var state: State = State.IDLE;

func set_mode(selected_mode: Mode) -> void:
	mode = selected_mode;
	
func set_state(selected_state: State) -> void:
	state = selected_state;
