extends Camera3D

@export var player_ref: Node3D
var relativePos = Vector3(0,5,8)
@onready var initZoom = size
var zoomfactor = 20
func _physics_process(delta: float) -> void:
	var target = GlobalVars.player_node.get_position() + relativePos
	var disp = (target - get_position())*0.5
	position += disp
	var targetZoom = initZoom + disp.length()*zoomfactor
	size += (targetZoom - size)*0.1
