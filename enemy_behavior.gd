extends Node3D

@export var player_ref: Node3D
@onready var area = $Area3D
@onready var cone = $Body
@onready var hpbar = $HPBar/Container/ProgressBar
var velocity: Vector3 = Vector3(0,0,0)
var seek_strength = Vector3(randf_range(5,10), 0 , randf_range(5,10))
var push_strength = Vector3(0.9,0.9,0.9)
var vel_lim = 30
var proc_lim = 20
var hp = 100
var hover_radius = randf_range(0.2,1.0)
var theta = randf_range(0,2*PI)
func _ready():
	player_ref = get_parent().player_ref
	_update_target_offset()

func _physics_process(delta: float) -> void:
	_look()
	_move(delta)
	_updateHpBar()
	

func _look() -> void:
	cone.look_at(player_ref.get_position())

func _move(delta:float) -> void:
	var target_offset = Vector3(hover_radius*sin(theta),0,hover_radius*cos(theta))
	if(get_position().distance_to(player_ref.get_position()+target_offset) < 0.1):
		_update_target_offset()
	velocity = ((player_ref.get_position()+target_offset) - get_position()).normalized()*seek_strength
	var bodies = area.get_overlapping_areas()
	var netPush = Vector3(0,0,0)
	for i in range(min(bodies.size(), proc_lim)):
		if(get_position().distance_squared_to(bodies[i].get_position())> 0.001):
			netPush += (get_position()-bodies[i].get_position())/get_position().distance_squared_to(bodies[i].get_position())
	velocity += netPush
	if(velocity.length() > vel_lim):
		velocity = velocity.normalized()*vel_lim
	translate(velocity*delta)

func _updateHpBar() -> void:
	hpbar.value = hp

func _update_target_offset() -> void:
	hover_radius = randf_range(0.5,1.5)
	theta += randf_range(0,PI/10)
