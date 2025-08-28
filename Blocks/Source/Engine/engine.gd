extends Source

@onready var timer: Timer = $Timer;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	new_block("engine", "source", output_dir);

func interact():
	if timer.is_stopped():
		timer.start(2.5);
	else:
		timer.stop();

func _on_timer_timeout() -> void:
	provide_power();
