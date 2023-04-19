extends Control

@export var max_points = 60
@export var fade_time = 2.0
@export var max_line_length = 160.0
@export var interact_intension = 3000.0
@export var min_radius = 0.5
@export var max_radius = 3.0
@export var min_velocity = 20.0
@export var max_velocity = 60.0
@export var point_color = Color.RED
@export var line_color = Color.WHITE
@export var Point_scene : PackedScene
var points = []


func _ready() -> void:
	for i in range(max_points):
		points.push_back(reset_po(Point_scene.instantiate()))


func reset_po(po:Po):
	var radius = get_rect()
	po.max_line_length = max_line_length
	po.line_color = line_color
	po.fade_time = fade_time
	po.point_color = point_color
	po.interact_intension = interact_intension
	po.get_node("Area2D/CollisionShape2D").shape.radius = max_line_length/2
	po.position = Vector2(randf_range(0,get_rect().size.x), randf_range(0,get_rect().size.y))
	po.velocity = Vector2.RIGHT.rotated(randf() * TAU) * randf_range(min_velocity, max_velocity)
	po.radius = randf_range(min_radius, max_radius)
	po.life = 0.0
	po.velocity2 = Vector2.ZERO
	return po

func _physics_process(delta) -> void:
	if get_parent().visible == false and get_parent().in_game == false:
		return
	for po in points:
		if !po.is_inside_tree():
			add_child(po)
		if !get_rect().has_point(po.position):
			po.life -= delta
			if po.life < 0.0:
				reset_po(po)
		else:
			po.life = min(po.life + delta, fade_time)
		po.position += (po.velocity + po.velocity2) * delta
	

