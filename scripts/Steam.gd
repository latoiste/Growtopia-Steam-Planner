extends Node2D
class_name Steam

signal give_steam;

@onready var sprite = $Sprite2D;
@onready var timer = $Timer;

var tween: Tween;
var current_block: Block;
var prev_dir: Vector2;
var next_dir: Vector2;
var initial_pos: Vector2;

func init(conductor: Conductor, prev_dir: Vector2) -> void:
	current_block = conductor;
	next_dir = conductor.get_next_dir(prev_dir);
	initial_pos = conductor.get_block_pos();
	set_steam_position(initial_pos);
	
	give_steam.connect(conductor.enter_steam, CONNECT_ONE_SHOT);
	give_steam.emit();
	
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
	current_block = Grid.get_block_at(initial_pos);
	
	if current_block:
		next_dir = current_block.get_next_dir(prev_dir);
		give_steam.connect(current_block.enter_steam, CONNECT_ONE_SHOT);
		give_steam.emit();
	else:
		kill_steam();
		
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
	await get_tree().create_timer(0.075).timeout;
	
	if give_steam.has_connections():
		var connections = give_steam.get_connections();
		for connection in connections:
			give_steam.disconnect(connection["callable"]);
		print("i will kill myself");
	
	queue_free();
	
func _process(delta: float) -> void:
	if not current_block:
		kill_steam();
	
	sprite.rotation_degrees += 360 * delta;
	
