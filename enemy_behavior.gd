extends Node3D

@export var player_ref: Node3D
@onready var area = $Area3D
@onready var cone = $Body
var velocity: Vector3 = Vector3(0,0,0)
var seek_strength = Vector3(10,0,10)
var push_strength = Vector3(1.5,0,1.5)
func _ready():
	pass

func _physics_process(delta: float) -> void:
	cone.look_at(player_ref.get_position())
	velocity = (player_ref.get_position() - get_position()).normalized()*seek_strength
	var rng = Vector3(randf_range(-1,1), 0, randf_range(-1,1))
	velocity += rng
	var bodies = area.get_overlapping_areas()
	for body in bodies:
		var push =  (get_position()-body.get_position()).normalized()
		velocity += push*push_strength
	translate(velocity*delta)
		
