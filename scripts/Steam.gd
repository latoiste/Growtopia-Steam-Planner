extends Node2D
class_name Steam

@onready var timer = $Timer;

var current_block: Conductor;
var prev_block = current_block;
var tween: Tween;
var prev_dir: Vector2;
var next_dir: Vector2;
var initial_pos: Vector2;

func init(block: Conductor, prev_dir: Vector2) -> void:
	current_block = block;
	next_dir = block.get_next_dir(prev_dir);
	initial_pos = block.get_block_pos();
	set_steam_position(initial_pos);
	current_block.has_steam = true;
	
func _ready() -> void:
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
	prev_dir = next_dir;
	initial_pos += next_dir;
	prev_block = current_block;
	current_block = Grid.get_block_at(initial_pos);
	next_dir = current_block.get_next_dir(prev_dir);
	
	prev_block.has_steam = false;
	current_block.has_steam = true;
	print("updated!");

func move_steam_animation(start_pos: Vector2, final_pos: Vector2) -> void:
	start_pos *= Constants.BLOCK_SIZE;
	final_pos *= Constants.BLOCK_SIZE;
	
	tween = create_tween();
	#tween.set_parallel();
	tween.tween_property(self, "position", final_pos, 1.0).from(start_pos);
	#tween.tween_property(self, "rotation_degrees", 45.0, 1.0).from(start_pos);
	
func set_steam_position(grid_pos: Vector2) -> void:
	position = grid_pos * Constants.BLOCK_SIZE;

func kill_steam() -> void:
	await get_tree().create_timer(0.2).timeout
	current_block.has_steam = false;
	queue_free();
