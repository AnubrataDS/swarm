extends Node3D

@export var player_ref: Node3D
@onready var area = $Area3D
@onready var cone = $Body
var velocity: Vector3 = Vector3(0,0,0)
var seek_strength = Vector3(10,0,10)
var push_strength = Vector3(0.9,0.9,0.9)
var vel_lim = 20
var proc_lim = 20
func _ready():
	player_ref = get_parent().player_ref

func _physics_process(delta: float) -> void:
	cone.look_at(player_ref.get_position())
	velocity = (player_ref.get_position() - get_position())*seek_strength
	var bodies = area.get_overlapping_areas()
	var netPush = Vector3(0,0,0)
	for i in range(min(bodies.size(), proc_lim)):
		netPush += (get_position()-bodies[i].get_position())*push_strength
	velocity += netPush
	if(velocity.length() > vel_lim):
		velocity = velocity.normalized()*vel_lim
	translate(velocity*delta)
