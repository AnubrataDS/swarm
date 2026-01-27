extends Node3D

@onready var mat = preload("res://bullet_mat.tres")

@export var look:Vector3
@export var origin: Vector3
@export var dir: Vector3
@onready var bulletBody = $BulletBody
var speed = 10
var disabled = false
func _ready():
	origin = get_position()
	dir = (look-origin).normalized()
	bulletBody.look_at(look)

func _physics_process(delta: float) -> void:
	if(disabled):
		$BulletBody.hide()
		pass
	if($Area3D.get_overlapping_areas().size()>0):
		$End.emitting = true
		disabled=true
		await get_tree().create_timer(0.1).timeout
		queue_free()
	translate(delta*dir*speed)

func set_color(color:Color):
	var material = $BulletBody/Bullet.get_active_material(0).duplicate()
	
	# Set the albedo color to blue
	material.albedo_color = color # Using float values

	# Apply the modified material back to the mesh instance
	$BulletBody/Bullet.set_surface_override_material(0, material)
	$BulletBody/Tracer.set_surface_override_material(0, material)

func _on_timer_timeout() -> void:
	$End.emitting = true
	disabled=true
	await get_tree().create_timer(1).timeout
	queue_free()
