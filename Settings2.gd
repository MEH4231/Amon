extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_values():
	$Setting_backround/CheckButton.pressed = OS.is_window_fullscreen()

func _on_CheckButton_toggled(button_pressed):
	OS.window_fullscreen = !OS.window_fullscreen


func _on_Exit_pressed():
	if $"/root/Main/Menu/Backround/Settings_button/Settings".visible:
		$"/root/Main/Menu/Backround/Settings_button/Settings".visible = !$"/root/Main/Menu/Backround/Settings_button/Settings".visible


func _on_Controls_pressed():
	$"Setting_backround/Controls/Control_menu".visible = !$"Setting_backround/Controls/Control_menu".visible
