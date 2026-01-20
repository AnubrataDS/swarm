extends MeshInstance3D

var m_color : Color = Color.GREEN

var m_material : ORMMaterial3D = ORMMaterial3D.new()

func _ready():
	mesh = ImmediateMesh.new()
	m_material.shading_mode = BaseMaterial3D.SHADING_MODE_UNSHADED
	m_material.albedo_color = Color(1,0,0.2)
	m_material.vertex_color_use_as_albedo = true
	
func _process(delta):
	draw()
	

func draw():
	mesh.clear_surfaces()
	mesh.surface_begin(Mesh.PRIMITIVE_LINES, m_material)
	mesh.surface_add_vertex(Vector3(0,0,0))
	mesh.surface_add_vertex(get_parent().lookingAt-get_parent().position)
	mesh.surface_end()
