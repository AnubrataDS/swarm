extends Node3D

@export var player_ref: Node3D
@onready var area = $Area3D
@onready var cone = $Body
@onready var coneShape = $Body/Cone
@onready var hpbar = $Body/HPBar/Container/ProgressBar
@onready var hitbox = $Hitbox
@onready var old_color = coneShape.get_surface_override_material(0).albedo_color
@onready var hitparticle = $HitParticle
@onready var deathparticles = $DeathParticles
var velocity = Vector3(0,0,0)
var seek_strength = Vector3(randf_range(10,15), 0 , randf_range(10,15))
var push_strength = Vector3(0.9,0.9,0.9)
var vel_lim = 30
var proc_lim = 20
var hp = 100
var hover_radius = randf_range(0.2,1.0)
var theta = randf_range(0,2*PI)
var dying = false;
func _ready():
	player_ref = get_parent().player_ref
	_update_target_offset()

func _physics_process(delta: float) -> void:
	if(!dying):
		_look()
		_move(delta)
		_blip()
		_updateHpBar()
		_checkDeath()
	

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

func _blip()->void:
	if(hitbox.get_overlapping_areas().size()>0):
		coneShape.get_surface_override_material(0).albedo_color = Color(2,2,2)
	else:
		coneShape.get_surface_override_material(0).albedo_color = old_color

func _checkDeath()->void:
	if(hp<=0):
		dying = true
		cone.hide()
		deathparticles.emitting = true
		await get_tree().create_timer(2.0).timeout
		queue_free()
	
func _on_hitbox_area_entered(area: Area3D) -> void:
	hp-=5
	hitparticle.emitting = true
	pass # Replace with function body.
