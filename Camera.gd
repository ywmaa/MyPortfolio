extends Node3D
var focus: bool = false
@export var target : NodePath

@export_range(0.0, 2.0) var rotation_speed : float = PI/2

# mouse properties
@export var mouse_control : bool = false
@export_range(0.001, 0.1) var mouse_sensitivity : float = 0.005
@export var invert_y : bool = false
@export var invert_x : bool = false

# zoom settings
@export var max_zoom : float = 3.0
@export var min_zoom : float = 0.4
@export_range(0.05, 1.0) var zoom_speed : float = 1.0

@export var zoom = 1.0

func get_mouse(delta):
	if Input.is_action_pressed("cam_zoom_in"):
		zoom -= zoom_speed * delta
	if Input.is_action_pressed("cam_zoom_out"):
		zoom += zoom_speed * delta
	zoom = clamp(zoom, min_zoom, max_zoom)

func get_input_keyboard(delta):
	# Rotate outer gimbal around y axis
	var y_rotation = 0
	if Input.is_action_pressed("cam_right"):
		y_rotation += 1
	if Input.is_action_pressed("cam_left"):
		y_rotation += -1
	rotate_object_local(Vector3.UP, y_rotation * rotation_speed * delta)
	# Rotate inner gimbal around local x axis
	var x_rotation = 0
	if Input.is_action_pressed("cam_up"):
		x_rotation += -1
	if Input.is_action_pressed("cam_down"):
		x_rotation += 1
	x_rotation = -x_rotation if invert_y else x_rotation
	$InnerGimbal.rotate_object_local(Vector3.RIGHT, x_rotation * rotation_speed * delta)

func _process(delta):
	if !focus:
		return
	get_mouse(delta)
	get_input_keyboard(delta)
	$InnerGimbal.rotation.x = clamp($InnerGimbal.rotation.x, -1.4, -0.01)
	scale = lerp(scale, Vector3.ONE * zoom, zoom_speed)
	if target:
		global_transform.origin = get_node(target).global_transform.origin
