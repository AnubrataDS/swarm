extends MeshInstance3D


func _physics_process(delta: float) -> void:
	var rng = Vector3(randf_range(-2,2), 0, randf_range(-2,2))
	position += rng*delta
