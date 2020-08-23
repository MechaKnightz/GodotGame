extends Control


onready var options = get_node("Options")
		

func _ready():
	$BackGround/Buttons/ExitButton.grab_focus()
	for button in $BackGround/Buttons.get_children():
		button.connect("pressed", self, "on_Button_pressed", [button.scene_to_load])

func on_Button_pressed(scene_to_load):
	get_tree().change_scene(scene_to_load)


func _on_OptionsButton_pressed():
	options.show()
