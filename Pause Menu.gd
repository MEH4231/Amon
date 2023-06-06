extends Control



func get_input():
	var esc = Input.is_action_just_pressed('ui_cancel')

	if esc:
		if !$'/root/Main/Menu/Backround'.visible:
			$CanvasLayer/Pause_Menu.visible = !$CanvasLayer/Pause_Menu.visible

func _ready():
	pass

func _process(delta):
	get_input()

func _on_Exit_pressed():
	$"CanvasLayer/Pause_Menu/Exit/Exit_really?".popup_centered()
	
func _on_Continue_pressed():
	$CanvasLayer/Pause_Menu.visible = !$CanvasLayer/Pause_Menu.visible
	


func _on_Settings_pressed():
	$CanvasLayer/Pause_Menu/Settings_button_game/VideoPlayer.visible = !$CanvasLayer/Pause_Menu/Settings_button_game/VideoPlayer.visible
	$CanvasLayer/Pause_Menu/Settings_button_game/VideoPlayer.play()


func _on_True_exit_pressed():
	$CanvasLayer/Pause_Menu.visible = !$CanvasLayer/Pause_Menu.visible
	$'/root/Main/Menu/Backround'.visible = !$'/root/Main/Menu/Backround'.visible
	$'/root/Main/Menu/'.get_child(2).queue_free()
	$'/root/Main/Menu/Backround/Camera2D'.current = true
	!$"CanvasLayer/Pause_Menu/Exit/Exit_really?".hide()

func _on_Exit_Continue_pressed():
	!$"CanvasLayer/Pause_Menu/Exit/Exit_really?".hide()
 
