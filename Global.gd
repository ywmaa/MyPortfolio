extends Node

enum view_layout{desktop, mobile} 
var view_size : view_layout = view_layout.desktop

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if DisplayServer.window_get_size().x > DisplayServer.window_get_size().y:
		view_size = view_layout.desktop
	else:
		view_size = view_layout.mobile
