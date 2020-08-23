extends Node

onready var menu = get_node("InGameMenu")
onready var options = get_node("InGameMenu/Options")

func _input(event):
	if event.is_action_pressed("InGameMenu"):
		if menu.is_visible():
			menu.hide()
		else:
			menu.show()
		
		if options.is_visible():
			options.hide()
	
		# Toggle fullscreen when pressing F11 or Alt + Enter
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	
	
