extends Node3D
const enemy_scene: PackedScene =  preload('res://enemy.tscn')
@onready
var player_ref = $Player
const count = 300;
func _ready():
	for i in range(count):
		var en = enemy_scene.instantiate()
		en.translate(Vector3(randf_range(-30,30), 0 , randf_range(-30,30)))
		en.player_ref = player_ref
		add_child(en)
