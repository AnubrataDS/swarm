extends Node3D

const bullet_scene: PackedScene =  preload('res://bullet.tscn')
var speed = 20
var viewPortSize: Vector2
func _ready():
	viewPortSize = get_viewport().size
func _physics_process(delta: float) -> void:
	var movt = Vector3(0,0,0)
	if Input.is_action_pressed("right"):
		movt += Vector3(1,0,0)
	if Input.is_action_pressed("left"):
		movt += Vector3(-1,0,0)
	if Input.is_action_pressed("up"):
		movt += Vector3(0,0,-1)
	if Input.is_action_pressed("down"):
		movt += Vector3(0,0,1)
	if Input.is_action_pressed("auto_attack"):
		var mouseCoords = get_viewport().get_mouse_position() - viewPortSize/2
		var angle = Vector3(mouseCoords.x/viewPortSize.x,0,mouseCoords.y/viewPortSize.y)
		var bullet = bullet_scene.instantiate()
		bullet.position = Vector3(position.x,0,position.z)
		bullet.look = Vector3(position.x,0,position.z)+angle
		get_parent().add_child(bullet)
		pass
	translate(movt.normalized()*delta*speed)
