extends Control


var projects: Array
func add_project_scene(scene):
	if scene.get_parent() == $ScrollContainer/VBoxContainer:
		return
	projects.append(scene)
	$ScrollContainer/VBoxContainer.add_child(scene)
	
func remove_project_scene(scene):
	projects.remove_at(projects.find(scene))
	$ScrollContainer/VBoxContainer.remove_child(scene)
	scene.queue_free()
	
