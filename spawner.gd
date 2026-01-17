extends Node3D
const enemy_scene: PackedScene =  preload('res://enemy.tscn')
@onready var player_ref = $Player
@onready var cam = $OrthoCam
const count = 500;
func _ready():
	cam.player_ref = player_ref
	for i in range(count):
		var en = enemy_scene.instantiate()
		en.translate(Vector3(randf_range(-30,30), 0 , randf_range(-30,30)))
		add_child(en)
