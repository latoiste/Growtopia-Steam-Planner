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
