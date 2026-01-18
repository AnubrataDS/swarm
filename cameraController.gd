extends Camera3D

@export var player_ref: Node3D
var relativePos = Vector3(0,6,10)
	
	
func _physics_process(delta: float) -> void:
	var target = player_ref.get_position() + relativePos
	position += (target - get_position())*0.5
	if Input.is_action_just_released("zoom_in"):
		size-=1
	if Input.is_action_just_released("zoom_out"):
		size+=1
