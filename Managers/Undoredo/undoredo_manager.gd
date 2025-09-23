extends Node
class_name UndoRedoManager

var undo_stack: Array[Array]; # Array[Array[Action]]
var redo_stack: Array[Array];
var queued_actions: Array[Action];

signal stack_changed(undo_empty: bool, redo_empty: bool);

func handle_undoredo_action(action: String) -> void:
	match action:
		"undo":
			undo();
		"redo":
			redo();

func register_action(block: Block, type: String) -> void:
	var block_id: int = block.block_id;
	var pos: Vector2 = block.block_pos; 
	var action := Action.new(type, block_id, pos);
	
	queued_actions.push_back(action);

func update_undo_stack() -> void:
	if queued_actions.is_empty():
		return;
	
	undo_stack.push_back(queued_actions.duplicate());
	queued_actions.clear();
	
	if not redo_stack.is_empty():
		redo_stack.clear();
		
	stack_changed.emit(undo_stack.is_empty(), redo_stack.is_empty());
	
func undo() -> void:
	if undo_stack.is_empty():
		return;
	var undo_action: Array[Action] = undo_stack.pop_back();
	var world: WorldManager = get_parent().get_manager("world");
	var action_size := undo_action.size();
	redo_stack.push_back(undo_action.duplicate());
	
	for i in range(action_size):
		var action: Action = undo_action.pop_back();
		if action.type == "place":
			world.delete_block(action.pos, false);
		elif action.type == "delete":
			var block_instance: PackedScene = Block.get_block_scene_by_id(action.block_id);
			world.place_block(block_instance, action.pos, false);
	stack_changed.emit(undo_stack.is_empty(), redo_stack.is_empty());
	
func redo() -> void:
	if not redo_stack:
		return;
	var redo_action: Array[Action] = redo_stack.pop_back();
	var world: WorldManager = get_parent().get_manager("world");
	var action_size := redo_action.size();
	undo_stack.push_back(redo_action.duplicate());
	
	for i in range(action_size):
		var action: Action = redo_action.pop_back();
		if action.type == "place":
			var block_instance: PackedScene = Block.get_block_scene_by_id(action.block_id);
			world.place_block(block_instance, action.pos, false);
		elif action.type == "delete":
			world.delete_block(action.pos, false);
	stack_changed.emit(undo_stack.is_empty(), redo_stack.is_empty());
	
class Action:
	var type: String;
	var block_id: int;
	var pos: Vector2;
	
	func _init(_type: String, _block_id: int, _pos: Vector2) -> void:
		type = _type;
		block_id = _block_id;
		pos = _pos;
