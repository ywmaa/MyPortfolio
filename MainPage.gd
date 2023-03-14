extends Control
var button_menu = preload("res://ButtonMenu.tscn")
var projects_view = preload("res://ProjectsView.tscn")
var preview_3d = preload("res://3DProject.tscn")

var portfolio_menu = button_menu.instantiate()
var games_menu = button_menu.instantiate()
var products_menu = button_menu.instantiate()


func _ready():
	Global.connect("view_size_changed",Update_Responsive_UI)
	$TopBar/Hbox/TextureButton.connect("pressed",ExpandMainMenu)
	
	_generate_menu_buttons()
	Update_Responsive_UI()
	
	
	var view = projects_view.instantiate()
	$PanelContainer/Control.add_sibling(view)
	
	
	var donut_preview = preview_3d.instantiate()
	donut_preview.assign_render_image(load("res://3DScenes/DonutTutorial/donutRender.png"))
	donut_preview.assign_scene(load("res://3DScenes/Donut.tscn").instantiate())
	
	view.add_project_scene(donut_preview)
	
	var donut_preview1 = preview_3d.instantiate()
	donut_preview1.assign_render_image(load("res://3DScenes/DonutTutorial/donutRender.png"))
	donut_preview1.assign_scene(load("res://3DScenes/Donut.tscn").instantiate())
	
	view.add_project_scene(donut_preview1)

func Update_Responsive_UI():
	ExpandMainMenu()
	if portfolio_menu.get_parent() != null:
		portfolio_menu.get_parent().remove_child(portfolio_menu)
		games_menu.get_parent().remove_child(games_menu)
		products_menu.get_parent().remove_child(products_menu)
	
	match Global.view_size:
		Global.view_layout.desktop:
			$TopBar/Hbox.add_child(products_menu)
			$TopBar/Hbox.add_child(games_menu)
			$TopBar/Hbox.add_child(portfolio_menu)
		Global.view_layout.mobile:
			$SidePanel/VBoxContainer.add_child(portfolio_menu)
			$SidePanel/VBoxContainer.add_child(games_menu)
			$SidePanel/VBoxContainer.add_child(products_menu)


func _generate_menu_buttons():
	portfolio_menu.init("PORTFOLIO","ABOUT",Callable(self,"about"))
	portfolio_menu.add_button("LEARNING JOURNEY",Callable(self,"learning"))
	portfolio_menu.add_button("PERSONAL PROJECTS",Callable(self,"personal_projects"))
	
	games_menu.init("GAMES","ROOM",Callable(self,"room"))
	games_menu.add_button("Time.DREAM",Callable(self,"time_dream"))
	
	products_menu.init("PRODUCTS","MY TOUCH",Callable(self,"my_touch"))
	products_menu.add_button("ADVANCED MOVEMENT SYSTEM GODOT",Callable(self,"amsg"))


func _process(delta):
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and get_global_mouse_position().x > 200:
		if $SidePanel.position.x == 0:
			ExpandMainMenu()

func ExpandMainMenu():
	var tween := create_tween()
	if Global.view_size == Global.view_layout.desktop:
		tween.tween_property($SidePanel,"position",Vector2(-200,0),0.1)
		return
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
