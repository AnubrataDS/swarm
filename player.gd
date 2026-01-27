extends Node3D

const bullet_scene: PackedScene =  preload('res://bullet.tscn')
var speed = 3
var viewPortSize: Vector2
@export var lookingAt: Vector3
var camera: Camera3D
var attack_time = 0.05
var elapsed_since_last_shot = 0
var recoil_strength = 0.02
var dodge_multiplier = 1.5
var stamina = 100
@onready var staminabar = $Body/Sprite3D/SubViewport/ProgressBar
@onready var muzzleFlash = $MuzzleFlash

func _ready():
	camera = get_parent().get_node("OrthoCam")
	viewPortSize = get_viewport().size
	
func _physics_process(delta: float) -> void:
	_mouseAimReader()
	_move(delta)
	_attack(delta)
	
func _move(delta:float)->void:
	var movt = Vector3(0,0,0)
	var mult = 1
	if Input.is_action_pressed("dodge"):
		if(stamina>0):
			mult = dodge_multiplier
			stamina -= 1
	else:
		if(stamina<100):
			stamina += 1
	if Input.is_action_pressed("right"):
		movt += Vector3(1,0,0)
	if Input.is_action_pressed("left"):
		movt += Vector3(-1,0,0)
	if Input.is_action_pressed("up"):
		movt += Vector3(0,0,-1)
	if Input.is_action_pressed("down"):
		movt += Vector3(0,0,1)
	var vel = movt.normalized()*delta*speed*mult
	translate(vel)  
	staminabar.value = stamina

func _attack(delta):
	if Input.is_action_pressed("auto_attack"):
		if(elapsed_since_last_shot >= attack_time):
			_shoot()
			elapsed_since_last_shot = 0
		else:
			elapsed_since_last_shot += delta
			

func _mouseAimReader():
	var mouse_position_3d: Vector3 = get_mouse_position_on_plane(get_viewport().get_mouse_position())
	lookingAt = mouse_position_3d

func get_mouse_position_on_plane(screen_position: Vector2) -> Vector3:
	# 1. Define the target plane in world space
	var target_plane := Plane(Vector3.UP, 0)

	# 2. Get the ray origin and direction from the camera using the mouse position
	var ray_origin: Vector3 = camera.project_ray_origin(screen_position)
	var ray_direction: Vector3 = camera.project_ray_normal(screen_position)

	# 3. Calculate the intersection point of the ray with the plane
	var intersection_point: Vector3 = target_plane.intersects_ray(ray_origin, ray_direction)

	# Return the intersection point if one is found
	if intersection_point != null:
		return intersection_point
	else:
		# Handle cases where the ray might be parallel to the plane (less likely with orthographic)
		return Vector3.INF # Or some other indicator of no intersection

func _shoot():
	muzzleFlash.emitting = true
	muzzleFlash.look_at(lookingAt)
	var bullet = bullet_scene.instantiate()
	bullet.position = position 
	var recoil = recoil_strength*(Vector3(randf_range(-1,1),0,randf_range(-1,1)))*(lookingAt-position).length()
	bullet.look = lookingAt + recoil
	get_parent().add_child(bullet)
