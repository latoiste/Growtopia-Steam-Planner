extends Node

# BLOCK SCENES
const BLOCKS: Dictionary = {
	"collector": "uid://6ruwp8q5nkxq",
	"crank": "uid://jom8h5cpaflf",
	"crossover": "uid://c42vopbjwddp3",
	"door": "uid://mf5yba3ubneh",
	"funnel": "uid://b6qdfofwdxc10",
	"funneldown": "uid://b72225wfa4juw",
	"funnelup": "uid://clb6s0nsyv5ek",
	"launcher": "uid://tuon10r6efg2",
	"organ": "uid://bjm5adujsb37w",
	"pipe": "uid://xqpuc0phpng0",
	"tubes": "uid://cuye5ggmiahfj",
	"valve": "uid://lb5n2nfdxpdm",
	"vent": "uid://biwhwmhbdhote",
	"engine": "uid://boipkeqb0lll6",
	"revolver": "uid://c7mag2f0lv3ut",
	"stomper": "uid://muqtkakm3gkd",
}

const STEAM_SCENE: PackedScene = preload("uid://btffcbbs7ojqg");
const BORDER_SCENE: PackedScene = preload("uid://ei4ickdodkmx");

const PIPE_TEXTURES: Array[Texture2D] = [
	preload("res://block sprites/Conductor/pipes/pipe_base.png"),
	preload("res://block sprites/Conductor/pipes/pipe_down.png"),
	preload("res://block sprites/Conductor/pipes/pipe_up.png"),
	preload("res://block sprites/Conductor/pipes/pipe_vertical.png"),
	preload("res://block sprites/Conductor/pipes/pipe_right.png"),
	preload("res://block sprites/Conductor/pipes/pipe_corner_DR.png"),
	preload("res://block sprites/Conductor/pipes/pipe_corner_UR.png"),
	preload("res://block sprites/Conductor/pipes/pipe_T_left.png"),
	preload("res://block sprites/Conductor/pipes/pipe_left.png"),
	preload("res://block sprites/Conductor/pipes/pipe_corner_DL.png"),
	preload("res://block sprites/Conductor/pipes/pipe_corner_UL.png"),
	preload("res://block sprites/Conductor/pipes/pipe_T_right.png"),
	preload("res://block sprites/Conductor/pipes/pipe_horizontal.png"),
	preload("res://block sprites/Conductor/pipes/pipe_T_up.png"),
	preload("res://block sprites/Conductor/pipes/pipe_T_down.png"),
	preload("res://block sprites/Conductor/pipes/pipe_cross.png"),
]
