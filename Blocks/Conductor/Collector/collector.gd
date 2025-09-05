extends Conductor

var latest_prev_dir: Vector2;
var steam_inside: Array[Steam];
const input_dir: Array[Vector2] = Constants.ALL_DIR;
const output_dir: Array[Vector2] = Constants.ALL_DIR;

func enter():
	super();
	new_block("Steam Collector", Constants.BLOCK_ID["collector"], output_dir, input_dir);

func enter_steam(sender: Steam):
	latest_prev_dir = sender.prev_dir;
	var valid_dirs := get_all_valid_dir();
	
	if valid_dirs.size() <= 1:
		return;
		
	steam_inside.append(sender);
	sender.steam_paused = true;
	
	await get_tree().process_frame;
	
	if steam_inside.size() >= valid_dirs.size():
		shoot_steam(valid_dirs);
	else:
		store_steam(sender);

func get_all_valid_dir() -> Array[Vector2]:
	var output_dirs: Array[Vector2] = Constants.ALL_DIR.duplicate();
	var valid_dirs: Array[Vector2];
	output_dirs.erase(latest_prev_dir * -1);
	
	for dir in output_dirs:
		if dir_is_valid(dir):
			valid_dirs.append(dir);
	return valid_dirs;

# set team to paused
# get timer
# connect to timeout
# store steam in steam_inside
func store_steam(steam: Steam) -> void:
	var timer: Timer = steam.get_node("Timer");
	timer.start(20);
	timer.timeout.connect(remove_steam.bind(steam), CONNECT_ONE_SHOT);

#also just start the timer again for 10 seconds, and disconnect
func shoot_steam(output_dirs: Array[Vector2]) -> void:
	var size := output_dirs.size()
	for i in range(size):
		if steam_inside.size() <= 0:
			break;
		var steam: Steam = steam_inside.pop_front();
		var next_dir: Vector2 = output_dirs.pop_front();
		
		remove_steam(steam);
		steam.next_dir = next_dir;
		steam.steam_paused = false;
		steam.start_steam();
	
func remove_steam(steam: Steam):
	var timer: Timer = steam.get_node("Timer");
	if timer.timeout.is_connected(remove_steam):
		timer.timeout.disconnect(remove_steam);
	steam_inside.erase(steam);
	#print(steam_inside);
