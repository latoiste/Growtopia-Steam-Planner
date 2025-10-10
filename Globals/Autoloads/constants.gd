extends Node

const NO_DIR = Vector2.ZERO;
const UP = Vector2(0, -1);
const DOWN = Vector2(0, 1);
const LEFT = Vector2(-1, 0);
const RIGHT = Vector2(1, 0);
const ALL_DIR: Array[Vector2] = [UP, DOWN, LEFT, RIGHT];

const BLOCK_SIZE = 16;

const BLOCK_ID = {
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
	"gear": 16,
	"bellows": 17,
	"bellowsriser": 18,
	"lamp": 19,
	"piston": 20,
	"pistonlifter": 21,
	"scrambler": 22,
	"spikes": 23,
}
