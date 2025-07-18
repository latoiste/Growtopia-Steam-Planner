extends Node2D
class_name Steam

@onready var timer = $Timer;

var tween: Tween;
var current_block: Block;
var prev_dir: Vector2;
var next_dir: Vector2;
var initial_pos: Vector2;

func init(block: Conductor, prev_dir: Vector2) -> void:
	current_block = block;
	next_dir = block.get_next_dir(prev_dir);
	initial_pos = block.get_block_pos();
	set_steam_position(initial_pos);
	current_block.has_steam = true;
	
	timer.start();
	start_steam();
	
func start_steam() -> void:
	var final_pos: Vector2;
	
	while next_dir:
		final_pos = initial_pos + next_dir;
		move_steam_animation(initial_pos, final_pos);
		await tween.finished;
		
		update_properties();
		
	kill_steam();

func update_properties() -> void:
	current_block.has_steam = false;
	prev_dir = next_dir;
	initial_pos += next_dir;
	current_block = Grid.get_block_at(initial_pos);
	
	if current_block and current_block is Conductor:
		next_dir = current_block.get_next_dir(prev_dir);
		current_block.has_steam = true;
	else:
		kill_steam();
		
	print("updated!");

func move_steam_animation(start_pos: Vector2, final_pos: Vector2) -> void:
	start_pos *= Constants.BLOCK_SIZE;
	final_pos *= Constants.BLOCK_SIZE;
	
	tween = create_tween();
	tween.tween_property(self, "position", final_pos, 0.075).from(start_pos);
	
func set_steam_position(grid_pos: Vector2) -> void:
	position = grid_pos * Constants.BLOCK_SIZE;

func kill_steam() -> void:
	if tween:
		tween.kill();
	await get_tree().create_timer(0.075).timeout
	
	if current_block and current_block is Conductor:
		current_block.has_steam = false;
	
	queue_free();
	
func _process(delta: float) -> void:
	print(current_block);
	if not current_block:
		print("killed")
		kill_steam();
