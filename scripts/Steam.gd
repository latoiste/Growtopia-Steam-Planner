extends Node2D
class_name Steam

signal give_steam;

@onready var sprite = $Sprite2D;
@onready var timer = $Timer;

var steam_paused: bool = false;
var tween: Tween;
var current_block: Block;
var prev_dir: Vector2;
var next_dir: Vector2;
var initial_pos: Vector2;

func init(source: Source, next_dir: Vector2) -> void:
	initial_pos = source.get_block_pos();
	self.next_dir = next_dir;
	set_steam_position(initial_pos);
	current_block = source.get_block_in_dir(next_dir);
	
	start_steam();
	
func start_steam() -> void:
	var final_pos: Vector2;
	timer.start(10);
	
	while next_dir:
		final_pos = initial_pos + next_dir;
		
		animate_steam(initial_pos, final_pos);
		await tween.finished;
		
		update_properties();
		
		if steam_paused:
			return;
			
	kill_steam();

func update_properties() -> void:
	#print("update_properties called");
	prev_dir = next_dir;
	initial_pos += next_dir;
	current_block = Grid.get_block_at(initial_pos);
	
	if current_block is Conductor:
		next_dir = current_block.get_next_dir(prev_dir);
		send_steam_signal(current_block);
	else:
		kill_steam();
		
func send_steam_signal(conductor: Conductor):
	#print("sent from: ", conductor);
	give_steam.connect(conductor.enter_steam.bind(self), CONNECT_ONE_SHOT);
	give_steam.emit();
	
func animate_steam(start_pos: Vector2, final_pos: Vector2) -> void:
	start_pos *= Constants.BLOCK_SIZE;
	final_pos *= Constants.BLOCK_SIZE;
	
	tween = create_tween();
	tween.tween_property(self, "position", final_pos, 0.15).from(start_pos);

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
	#print(current_block);
	sprite.rotation_degrees += 360 * delta;
	
