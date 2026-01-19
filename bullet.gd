extends Node3D

@export var look:Vector3
@export var origin: Vector3
@export var dir: Vector3
var speed = 1
func _ready():
	origin = get_position()
	dir = look

func _physics_process(delta: float) -> void:
	translate(delta*dir*speed)


func _on_area_3d_area_entered(area: Area3D) -> void:
	queue_free()
