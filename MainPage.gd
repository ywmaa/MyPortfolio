extends Control
var button_menu = preload("res://ButtonMenu.tscn")
var preview_3d = preload("res://3DView.tscn")

func _ready():
	$TopBar/Hbox/TextureButton.connect("pressed",ExpandMainMenu)
	var portfolio_menu = button_menu.instantiate()
	portfolio_menu.init("PORTFOLIO","ABOUT",Callable(self,"about"))
	portfolio_menu.add_button("LEARNING JOURNEY",Callable(self,"learning"))
	portfolio_menu.add_button("PERSONAL PROJECTS",Callable(self,"personal_projects"))
	$SidePanel/VBoxContainer.add_child(portfolio_menu)
	var games_menu = button_menu.instantiate()
	games_menu.init("GAMES","ROOM",Callable(self,"room"))
	games_menu.add_button("Time.DREAM",Callable(self,"time_dream"))
	$SidePanel/VBoxContainer.add_child(games_menu)
	var products_menu = button_menu.instantiate()
	products_menu.init("PRODUCTS","MY TOUCH",Callable(self,"my_touch"))
	products_menu.add_button("ADVANCED MOVEMENT SYSTEM GODOT",Callable(self,"amsg"))
	$SidePanel/VBoxContainer.add_child(products_menu)
	
	var donut_preview = preview_3d.instantiate()
	$Control.add_sibling(donut_preview)
	donut_preview.assign_render_image(load("res://3DScenes/DonutTutorial/donutRender.png"))
	donut_preview.assign_scene(load("res://3DScenes/Donut.tscn").instantiate())

	

func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and get_global_mouse_position().x > 200:
		if $SidePanel.position.x == 0:
			ExpandMainMenu()

func ExpandMainMenu():
	var tween := create_tween()
	if $SidePanel.position.x == -200:
		tween.tween_property($SidePanel,"position",Vector2(0,0),0.1)
	if $SidePanel.position.x == 0:
		tween.tween_property($SidePanel,"position",Vector2(-200,0),0.1)

func about():
	ExpandMainMenu()
	print("open about")
func learning():
	ExpandMainMenu()
	print("open learnings")
func personal_projects():
	ExpandMainMenu()
	print("open projects")

func room():
	ExpandMainMenu()
	print("open room")
func time_dream():
	ExpandMainMenu()
	print("open time.dream")
	
func my_touch():
	ExpandMainMenu()
	print("open my touch")
func amsg():
	OS.shell_open("https://github.com/ywmaa/Advanced-Movement-System-Godot")
