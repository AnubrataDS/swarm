extends Node3D

const bullet_scene: PackedScene =  preload('res://bullet.tscn')
@export var lookingAt: Vector3
@onready var muzzleFlash = $MuzzleFlash
var attack_time = 0.5
var elapsed_since_last_shot = 0
var aim_color = Color(1,2,0)
func _ready() -> void:
	lookingAt = Vector3(0,0,0)
	
func _physics_process(delta: float) -> void:
	lookingAt = GlobalVars.player_node.get_position()
	if(elapsed_since_last_shot >= attack_time):
		_shoot()
		elapsed_since_last_shot = 0
	else:
		elapsed_since_last_shot += delta


func _shoot():
	muzzleFlash.emitting = true
	muzzleFlash.look_at(lookingAt)
	var bullet = bullet_scene.instantiate()
	bullet.position = position
	bullet.look = lookingAt
	bullet.set_color(Color(6,2,2))
	get_parent().add_child(bullet)
