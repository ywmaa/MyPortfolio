extends Node2D
class_name Po

var velocity
var radius
var velocity2
var other_points : Array[Node2D]
var max_line_length : float
var line_color : Color
var point_color : Color
var life : float
var fade_time : float
var interact_intension : float 



func _physics_process(delta):
	if get_parent().get_parent().visible == false and get_parent().get_parent().in_game == false:
		return
	queue_redraw()

func _draw():
	var pMousePos : Vector2 = get_local_mouse_position()
	var pColor : Color
	var lColor : Color
	# do certain functions for every point
	pColor = point_color
	pColor.a = life / fade_time
	draw_circle(position, radius, pColor)
	# update point velocity with the mouse position
	var mouse_dist = position.distance_to(pMousePos)
	if mouse_dist < max_line_length:
		velocity2 = (position - pMousePos).normalized() * (1.0 / mouse_dist) * interact_intension
	else :
		velocity2 = Vector2.ZERO
	for point in other_points:
		var distance = self.position.distance_to(point.position)
		if distance < max_line_length:
			lColor = line_color
			lColor.a = (1.0 - distance / max_line_length) * min( self.life, point.life) / fade_time
			draw_line(self.position, point.position, lColor, 2.0 * (1.0 - distance / max_line_length))





func _on_area_2d_area_entered(area):
	other_points.append(area.get_parent())


func _on_area_2d_area_exited(area):
	other_points.remove_at(other_points.find(area.get_parent()))


