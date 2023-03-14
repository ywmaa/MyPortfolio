extends Control
class_name ButtonMenu
@export var buttons : Array[Button]

func init(main_button_name:String, first_button_name:String, call:Callable):
	$VBoxContainer/ExpandButton.text = main_button_name
	$VBoxContainer/Button2.text = first_button_name
	$VBoxContainer/Button2.connect("pressed", call)
	

func _ready():
	buttons.append($VBoxContainer/Button2)
	$VBoxContainer/ExpandButton.connect("pressed",ShowHideButtons)


func ShowHideButtons():
	if buttons[0].visible:
		for button in buttons:
			button.hide()
	else:
		for button in buttons:
			button.show()

func add_button(p_name:String, call:Callable) -> ButtonMenu:
	var new_button : Button = $VBoxContainer/Button2.duplicate()
	new_button.text = p_name
	new_button.connect("pressed",call)
	$VBoxContainer.add_child(new_button)
	buttons.append(new_button)
	return self
