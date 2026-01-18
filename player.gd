extends Node3D


var speed = 30
func _physics_process(delta: float) -> void:
	var inpVel = Vector3(0,0,0)
	if Input.is_action_pressed("right"):
		inpVel += Vector3(1,0,0)
	if Input.is_action_pressed("left"):
		inpVel += Vector3(-1,0,0)
	if Input.is_action_pressed("up"):
		inpVel += Vector3(0,0,-1)
	if Input.is_action_pressed("down"):
		inpVel += Vector3(0,0,1)
	
	translate(inpVel*speed*delta)
