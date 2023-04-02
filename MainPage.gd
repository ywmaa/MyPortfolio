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
	
	
	learning()
	

func Update_Responsive_UI():
	ExpandMainMenu()
	if portfolio_menu.get_parent() != null:
		portfolio_menu.get_parent().remove_child(portfolio_menu)
#		games_menu.get_parent().remove_child(games_menu)
		products_menu.get_parent().remove_child(products_menu)
	
	match Global.view_size:
		Global.view_layout.desktop:
			$TopBar/Hbox.add_child(products_menu)
#			$TopBar/Hbox.add_child(games_menu)
			$TopBar/Hbox.add_child(portfolio_menu)
		Global.view_layout.mobile:
			$SidePanel/VBoxContainer.add_child(portfolio_menu)
#			$SidePanel/VBoxContainer.add_child(games_menu)
			$SidePanel/VBoxContainer.add_child(products_menu)


func _generate_menu_buttons():
	portfolio_menu.init("PORTFOLIO","ABOUT",Callable(self,"about"))
	portfolio_menu.add_button("MY LEARNING JOURNEY",Callable(self,"learning"))
#	portfolio_menu.add_button("PERSONAL PROJECTS",Callable(self,"personal_projects"))
	
#	games_menu.init("GAMES","ROOM",Callable(self,"room"))
#	games_menu.add_button("Time.DREAM",Callable(self,"time_dream"))
	
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
	OS.shell_open("https://1drv.ms/w/s!AkC9MtA3eaNDgQwZwaTVCJvxe2tf?e=TSOnAX")

var view = projects_view.instantiate()
func learning():
	ExpandMainMenu()
	if view.get_parent() != null:
		view.visible = !view.visible
		return
	
	$PanelContainer/Control.add_sibling(view)
	
	
	
	var donut_preview = preview_3d.instantiate()
	donut_preview.assign_render_image(load("res://3DScenes/DonutTutorial/donutRender.png"))
	donut_preview.assign_scene(preload("res://3DScenes/DonutTutorial/Donut.tscn").instantiate())
	donut_preview.set_note('The first tutorial I used to learn blender, the awesome tutorial is from "Blender Guru" of course :) ')
	
	view.add_project_scene(donut_preview)
	
	var apple_preview = preview_3d.instantiate()
	apple_preview.assign_render_image(load("res://3DScenes/AppleTutorial/ApplesSceneCycles.jpeg"))
	apple_preview.assign_scene(preload("res://3DScenes/AppleTutorial/ApplesWithKnifeWholeScene.scn").instantiate())
	apple_preview.set_note('The Second Tutorial, provided by "CG Boost", an awesome tutorial that got me more into the tools provided by blender')
	
	view.add_project_scene(apple_preview)
	
	var eevee_env_preview = preview_3d.instantiate()
	eevee_env_preview.assign_render_image(load("res://3DScenes/EeveeEnv1/EeveeEnv1.png"))
	eevee_env_preview.set_note('thanks for "Ducky 3D" for providing a tutorial for this simple abstract environment in eevee engine (blender), also I use "Humen Generator V3 3D" addon for blender')
	view.add_project_scene(eevee_env_preview)
	
	
	var planet_preview = preview_3d.instantiate()
	planet_preview.assign_render_image(load("res://3DScenes/Planet/Planet.png"))
	planet_preview.set_note('by learning from different tutorials for creating Planet Earth, this is what I got.')
	view.add_project_scene(planet_preview)
	
	
	var concept_preview = preview_3d.instantiate()
	concept_preview.assign_render_image(load("res://3DScenes/ConceptArt/concept_art.jpeg"))
	concept_preview.set_note('thanks to "Max Hay" advices about geometry nodes in blender, and geometry nodes tutorials from "Blender Guru", I was able to create this as my first Concept Art in blender')
	view.add_project_scene(concept_preview)


#func personal_projects():
#	ExpandMainMenu()
#	print("open projects")

#func room():
#	ExpandMainMenu()
#	print("open room")
#func time_dream():
#	ExpandMainMenu()
#	print("open time.dream")
	
func my_touch():
	ExpandMainMenu()
	OS.shell_open("https://github.com/ywmaa/my-touch")
func amsg():
	OS.shell_open("https://github.com/ywmaa/Advanced-Movement-System-Godot")
