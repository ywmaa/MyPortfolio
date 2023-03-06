extends Control
var viewport_initial_size = Vector2()

@onready var viewport = $SubViewport
@onready var viewport_sprite = $ScrollContainer/HBoxContainer/Control/Control/ViewportSprite
@onready var render_image = $ScrollContainer/HBoxContainer/Control2/TextureRect

func _ready():
	get_viewport().size_changed.connect(self._root_viewport_size_changed)
	viewport_initial_size = viewport.size

# Called when the root's viewport size changes (i.e. when the window is resized).
# This is done to handle multiple resolutions without losing quality.
func _root_viewport_size_changed():
	# The viewport is resized depending on the window height.
	# To compensate for the larger resolution, the viewport sprite is scaled down.
	viewport.size = Vector2.ONE * get_viewport().size.y
	viewport_sprite.scale = Vector2.ONE * viewport_initial_size.y / get_viewport().size.y

func assign_render_image(tex:Texture2D):
	if render_image:
		render_image.texture = tex

func assign_scene(node:Node3D):
	if viewport:
		for child in viewport.get_children():
			child.queue_free()
		viewport.add_child(node)
