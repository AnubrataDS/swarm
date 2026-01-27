extends MeshInstance3D

var player_ref: Node3D
var m_color : Color = Color.GREEN

var m_material : ORMMaterial3D = preload("res://sniper_line_mat.tres")

func _ready():
	mesh = ImmediateMesh.new()
	
func _process(delta):
	draw()
	

func draw():
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES, m_material)
	mesh.surface_add_vertex(Vector3(0,0,0))
	mesh.surface_add_vertex(get_parent().lookingAt-get_parent().position)
	mesh.surface_end()

func update_color(clr:Color):
	m_material.albedo_color = clr
