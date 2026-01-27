extends Node3D
const enemy_scene: PackedScene =  preload('res://seeker.tscn')
@onready var player_node = $Player
@onready var cam = $OrthoCam
@onready var sniper = $Sniper
const count = 50;
func _ready():
	GlobalVars.player_node = player_node
	for i in range(count):
		var en = enemy_scene.instantiate()
		en.translate(Vector3(randf_range(-30,30), 0 , randf_range(-30,30)))
		add_child(en)
