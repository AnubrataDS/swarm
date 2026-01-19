extends Node3D

@export var look:Vector3
var origin
var dir
var speed = 5
func _ready():
	origin = get_position()
	dir = (look-origin).normalized()

func _physics_process(delta: float) -> void:
	translate(delta*dir*speed)


func _on_area_3d_area_entered(area: Area3D) -> void:
	queue_free()
