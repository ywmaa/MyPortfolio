extends Node

enum view_layout{desktop, mobile} 
var view_size : view_layout = view_layout.desktop
signal view_size_changed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DisplayServer.window_get_size().x > DisplayServer.window_get_size().y:
		if view_size != view_layout.desktop:
			view_size = view_layout.desktop
			emit_signal("view_size_changed")
	else:
		if view_size != view_layout.mobile:
			view_size = view_layout.mobile
			emit_signal("view_size_changed")
