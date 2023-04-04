extends HBoxContainer
var viewport_initial_size = Vector2()
var camera
var focus : bool = false:
	set(value):
		focus = value
		if camera:
			camera.focus = focus
		else:
			camera = find_child("CameraGimbal",true,false)
@export var viewport : SubViewport
@export var viewport_sprite : Sprite2D
@export var render_image : TextureRect


func _process(delta):
	var scroll_percentage = (get_parent().get_parent().scroll_vertical+get_viewport().size.y/2)/get_rect().position.y
	scroll_percentage = clamp(scroll_percentage,0.0,1.0)
	$Control2.position.x = lerp($Control2.position.x,lerp(-($Control2.size.x),0.0,scroll_percentage),delta*10)
	$Control.position.x = lerp($Control.position.x,lerp(get_viewport().size.x+$Control.size.x,$Control.size.x+4.0,scroll_percentage),delta*10)
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and focus:
		get_parent().get_parent().scroll_horizontal += -(Input.get_last_mouse_velocity()/50).x
		get_parent().get_parent().scroll_vertical += -(Input.get_last_mouse_velocity()/50).y
	focus = get_global_rect().has_point(get_global_mouse_position())

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
			$Control/Control/ViewportSprite/NoSceneWarning.visible = true
			$Control/ControlGuide.visible = false
			child.queue_free()
		viewport.add_child(node)
		$Control/Control/ViewportSprite/NoSceneWarning.visible = false
		$Control/ControlGuide.visible = true

func set_note(text:String):
	$Control2/Notes.text = text
