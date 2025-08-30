extends Node

const NO_DIR = Vector2.ZERO;
const UP = Vector2(0, -1);
const DOWN = Vector2(0, 1);
const LEFT = Vector2(-1, 0);
const RIGHT = Vector2(1, 0);
const ALL_DIR: Array[Vector2] = [UP, DOWN, LEFT, RIGHT];

const BLOCK_SIZE = 16;

const MAX_ZOOM_IN = Vector2(7, 7);
const MAX_ZOOM_OUT = Vector2(1, 1);

const BLOCK_ID: Dictionary = {
	"collector": 0,
	"crank": 1,
	"crossover": 2,
	"door": 3,
	"funnel": 4,
	"funneldown": 5,
	"funnelup": 6,
	"launcher": 7,
	"organ": 8,
	"pipe": 9,
	"tubes": 10,
	"valve": 11,
	"vent": 12,
	"engine": 13,
	"revolver": 14,
	"stomper": 15,
}

func string_to_block_id(block_name: String):
	pass;
