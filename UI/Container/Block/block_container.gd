extends GridContainer
class_name BlockContainer

const BUTTON_NAME_TO_ID := {
	"Collector": BlockID.COLLECTOR,
	"Crank": BlockID.CRANK,
	"Crossover": BlockID.CROSSOVER,
	"Door": BlockID.DOOR,
	"Funnel": BlockID.FUNNEL,
	"FunnelDown": BlockID.FUNNELDOWN,
	"FunnelUp": BlockID.FUNNELUP,
	"Launcher": BlockID.LAUNCHER,
	"Organ": BlockID.ORGAN,
	"Pipe": BlockID.PIPE,
	"Tubes": BlockID.TUBES,
	"Valve": BlockID.VALVE,
	"Vent": BlockID.VENT,
	"Engine": BlockID.ENGINE,
	"Revolver": BlockID.REVOLVER,
	"Stomper": BlockID.STOMPER,
	"Gear": BlockID.GEAR,
	"Bellows": BlockID.BELLOWS,
	"BellowsRiser": BlockID.BELLOWSRISER,
	"Lamp": BlockID.LAMP,
	"Piston": BlockID.PISTON,
	"PistonLifter": BlockID.PISTONLIFTER,
	"Scrambler": BlockID.SCRAMBLER,
	"Spikes": BlockID.SPIKES,
}

func _ready() -> void:
	for child in get_children():
		child.set_meta("signal_params", BUTTON_NAME_TO_ID[child.name]);
